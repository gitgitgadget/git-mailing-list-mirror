From: Aubin LaBrosse <aubin@stormboxes.com>
Subject: StGIT mail configuration
Date: Mon, 13 Feb 2006 15:47:46 -0500
Message-ID: <43F0F072.90609@stormboxes.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080409010400090309010001"
X-From: git-owner@vger.kernel.org Mon Feb 13 21:48:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8kbw-0003UN-4N
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 21:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWBMUru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 15:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWBMUrt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 15:47:49 -0500
Received: from mail.stormboxes.com ([207.234.184.232]:43413 "EHLO
	dedicated.stormboxes.com") by vger.kernel.org with ESMTP
	id S964858AbWBMUrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 15:47:49 -0500
Received: from [192.168.1.101] (c-24-62-216-234.hsd1.nh.comcast.net [24.62.216.234])
	(authenticated bits=0)
	by dedicated.stormboxes.com (8.12.10/8.12.10) with ESMTP id k1DKWb6x022618;
	Mon, 13 Feb 2006 15:32:37 -0500
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
To: catalin.marinas@gmail.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16081>

This is a multi-part message in MIME format.
--------------080409010400090309010001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm using StGIT 0.8.1 on top of the latest release of Cogito - in 
.git/stgitrc of a local git repo, I have the following part related to 
my mail configuration:

smtpserver: mail.stormboxes.com:25
smtpuser: username@stormboxes.com
smtppassword: myPassword

(actual username and password redacted, of course) - the point is, the 
username actually is that entire string 'username@stormboxes.com' (no 
quotes) because the box it's on is a virtual server for many domains and 
the usernames must contain the domain to which they belong.  anyway, i 
was getting authentication failures, so i hacked up mail.py and set the 
debug level on the smtp object - i found out that it's trying to auth 
using CRAM-MD5.  And I'm not sure whether the server doesn't support 
that or not, but i didn't see anything in the python doc that would 
indicate that i could make the login() method use auth login or auth 
plain or something else, and it seems like it gets a valid response from 
the server that tells it that the authentication failed - and i'm not 
sure why - thunderbird works fine but i can't figure out which auth type 
it's using. (suppose i could tcpdump it and see) I have, of course, 
triple checked my auth credentials at this point. 

does anyone have any hints or insights, or is this a server 
configuration problem?  any help would be greatly appreciated.  Please 
CC, as I am not subscribed to the git list. 

Thanks,

Aubin LaBrosse

--------------080409010400090309010001
Content-Type: text/x-vcard; charset=utf-8;
 name="aubin.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aubin.vcf"

begin:vcard
fn:Aubin LaBrosse
n:LaBrosse;Aubin
email;internet:aubin@stormboxes.com
tel;work:589-0692
tel;home:429-1520
tel;cell:493-0121
version:2.1
end:vcard


--------------080409010400090309010001--
