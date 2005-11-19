From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 22:31:24 -0800 (PST)
Message-ID: <20051119063125.40234.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 07:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdMG9-000504-0Y
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 07:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVKSGbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 01:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKSGbb
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 01:31:31 -0500
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:12409 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751423AbVKSGbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 01:31:31 -0500
Received: (qmail 40237 invoked by uid 60001); 19 Nov 2005 06:31:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PaolBlCqS1sa3joSHXcrcddMRZlC4aM/dlFIlF/pP+vb/06GkyQz/HmEkU6UJCm3c4AMdbgB6RJYRYtyLBDbnPipGR0njel8GeLFbpHbl+/wLmqNIHHezvDZkEHoX0JjvfcSSs/4TF3KgcPDlR+acVCAj8Q13vqYwaDFWQTvB6g=  ;
Received: from [151.44.24.124] by web26303.mail.ukl.yahoo.com via HTTP; Fri, 18 Nov 2005 22:31:24 PST
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12322>

H. Peter Anvin wrote:

> Junio C Hamano wrote:
>
>> I just looked at the diff this commit introduces:
>>
>>     e6bd23911efd0a2bd756c77d9e7ba6576eb739a1
>>         Documentation: asciidoc sources are utf-8
>>
>> with gitk (BTW, I pulled from paulus today, so "master" branch
>> has the latest gitk) while my locale set to LC_CTYPE=en_US.utf8.
>>
>> Surprisingly, the diff to Documentation/git-pack-redundant.txt,
>> which changes Lukas' name originally incorrectly encoded in
>> iso-8859-1 to utf-8, was shown and both pre-image and post-image
>> lines are readable.
>>
>> I do not know how tcl/tk does it, but it is doing the right
>> thing.
>>
>
> Tcl/Tk assumes that anything that isn't valid UTF-8 is Latin-1.
>
>     -hpa
> -
My locale is set to LC_CTYPE=it_IT (local codec is ISO 8859-15).

Gitk shows correctly pre-image lines, but not post-image. BTW it's 
the same output I have with

      git-diff-tree -p e6bd23911efd0a2bd756c77d9e7ba6576eb739a1

run from KDE Konsole.

So I think the local encoding (LC_CTYPE) has a role in the story.

Marco



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
