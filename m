From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: .gitignore don't ignore a file
Date: Sat, 10 Sep 2011 13:01:20 +0200
Message-ID: <4E6B4380.4050009@isy.liu.se>
References: <4E6B3C19.4040908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bastien Sevajol <sevajol.bastien@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 13:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2LP9-0001GM-70
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 13:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759211Ab1IJLHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 07:07:01 -0400
Received: from muon.isy.liu.se ([130.236.48.25]:59464 "EHLO muon.isy.liu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759176Ab1IJLHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 07:07:01 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Sep 2011 07:07:00 EDT
Received: from [192.168.13.33] (g228081100.adsl.alicedsl.de [92.228.81.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by muon.isy.liu.se (Postfix) with ESMTPSA id BD84CE9E;
	Sat, 10 Sep 2011 13:01:23 +0200 (MEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
In-Reply-To: <4E6B3C19.4040908@gmail.com>
X-Enigmail-Version: 1.1.1
X-ISY-LIU-SE-MailScanner-Information: Please contact postmaster@isy.liu.se for more information
X-ISY-LIU-SE-MailScanner-ID: BD84CE9E.A83C5
X-ISY-LIU-SE-MailScanner: Found to be clean
X-ISY-LIU-SE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=0, required 6, ALL_TRUSTED -1.00, KHOP_SC_TOP_CIDR8 1.00)
X-ISY-LIU-SE-MailScanner-From: hendeby@isy.liu.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181152>

Hi!

On 09/10/2011 12:29 PM, Bastien Sevajol wrote:
> Hello !
> I don't understand why my gitingnore don't want to ignore a file.
> I have this in my gitignore:
> 
>> app/cache/
>> app/logs/
>> app/logs/dev.log
>> app/logs/prog.log
>> app/logs/test.log
>> *.log
>> *.*~
>> nbproject
> 
> i've try with app/logs/.gitignore with this:
> 
>> dev.log
> 
> But, git don't ignore app/logs/dev.log :/
> 
> Do you now why ?
> thank's =)

Is the file currently committed (or staged) to your repository?  In that
case; Git never ignore files that are put under version control.  If
not, could you please elaborate a bit more on in what way the file is
not ignored.  It is not completely clear to me what you expect, and what
in fact happens.

/Gustaf
