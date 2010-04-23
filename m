From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Fri, 23 Apr 2010 07:27:52 +0200
Message-ID: <201004230727.52212.chriscool@tuxfamily.org>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004202014.19477.jnareb@gmail.com> <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 07:31:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5BTk-0006mV-FY
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 07:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab0DWFa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 01:30:56 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59379 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630Ab0DWFaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 01:30:55 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0EE758180A3;
	Fri, 23 Apr 2010 07:30:44 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 79E1181807C;
	Fri, 23 Apr 2010 07:30:41 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145587>

On Wednesday 21 April 2010 22:49:02 Pavan Kumar Sunkara wrote:
> 1.What is the goal of your project?
> The project goal is to try and implement write functionalities into gitweb
> to go along with it's browsing functionalities. Another goal is to split
> gitweb Perl script and reorganize its structure. I would like to split the
> gitweb script in such a way that, in the future others will be able to
> develop more functionalities for gitweb (let it be 'read' or 'write'
> actions) with the help of the framework like structure of the new gitweb.
> 
> 'read' means browsing through the code and repository
> 'write' means working on the code and repository.
> 
> I will be describing about them detailedly in the later parts of the
> proposal.

Perhaps this sentence could be worded like this:

"I will describe in detail the read and write actions in the later part of the 
proposal."
 
> 2.How would you measure its success or failure?
> There are two parameters which would majorly determine the success or
> failure of the project.
> 
>    * Splitting gitweb such that there should be no problem with the
> installation of gitweb across cross servers and cross systems.
>    * Working with new addition to gitweb should be as easy as working with
> other git GUIs (git commit tools)
>    * User friendly graphical interface with smart UI design
> 
> 3.Describe your project in more detail.
> I would like to split the currently 6800 long piece of code in
> gitweb.plperl script into small files which will result in better
> readability,
> maintainability and modifiability. The file structure of the new gitweb is
> given below and I will explain the working after it.
> 
> (From now on, I would like to call the actions of gitweb as modules of
> gitweb)

Perhaps it would be better to state that in the end each action will have its 
own Perl module.

Though I agree with Petr that first you should probably just shuffle around all 
the utility routines in one module and develop write actions in another module 
that uses the first one.

Thanks,
Christian.
