From: Andreas Ericsson <ae@op5.se>
Subject: Re: empty directories and git Question
Date: Thu, 16 Sep 2010 10:32:49 +0200
Message-ID: <4C91D631.9010108@op5.se>
References: <loom.20100916T095344-932@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anton <tmp009@allproducts.info>
X-From: git-owner@vger.kernel.org Thu Sep 16 10:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow9zr-0003Om-5T
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 10:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab0IPIjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 04:39:05 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50414 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750813Ab0IPIjE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 04:39:04 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2010 04:39:03 EDT
Received: from source ([209.85.215.46]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJHXpsMn7cfSfo+zEOS5BzLHuk1PuS59@postini.com; Thu, 16 Sep 2010 01:39:04 PDT
Received: by ewy23 with SMTP id 23so471815ewy.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 01:38:59 -0700 (PDT)
Received: by 10.213.26.14 with SMTP id b14mr2582467ebc.15.1284625972420;
        Thu, 16 Sep 2010 01:32:52 -0700 (PDT)
Received: from clix.int.op5.se (fw1-sth-pio.op5.com [109.228.142.130])
        by mx.google.com with ESMTPS id a48sm3520654eei.18.2010.09.16.01.32.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 01:32:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6 ThunderGit/0.1a
In-Reply-To: <loom.20100916T095344-932@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156298>

On 09/16/2010 09:59 AM, Anton wrote:
> Hi!
> 
> I am using git for a very long time with TextMate and Ruby on Rails,
> now I am working with Eclipse and Android and I have a stupid problem
> (or I am stupid...). Can anybody help me?
> 
> I have directories which I do not want to track in git (like gen/* an bin/*).
> They can be ignored by adding them to the .gitignore - works well.
> 
> But when I clone the project Eclipse shouts about the missing directories.
> So I tried the following:
> 
> added a .ignoreme file to "bin" and "gen", ignored everything else.
> Works fine, now the directory and the two .ignoreme files are added,
> but Eclipse does not like to have any file in the bin directory
> (can't build until I remove it).
> 
> So it there no way to manage bin folders of any kind
> in git when working with IDEs?
> 

You can't have empty directories in git. Eclipse forcing you to have a
pre-created empty directory that it doesn't create itself if it doesn't
exist sounds mightily weird though. I'd guess there's some setting in
eclipse that tells it to automagically create or wipe the directory if
it needs to. It's not like it's a small project, so I can't imagine a
simple thing like that not being handled.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
