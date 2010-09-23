From: Andreas Ericsson <ae@op5.se>
Subject: Re: recursive aliases
Date: Thu, 23 Sep 2010 13:34:02 +0200
Message-ID: <4C9B3B2A.2080604@op5.se>
References: <AANLkTi=VDmyhUDYKc38bOZWLncZ_twQGB2n5KgbgP_tf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 13:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyk4B-0000EO-R6
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 13:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab0IWLeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 07:34:09 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49528 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754532Ab0IWLeI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 07:34:08 -0400
Received: from source ([209.85.215.41]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJs7LREX+58RoYGd0izcCQguox+I6nX5@postini.com; Thu, 23 Sep 2010 04:34:07 PDT
Received: by ewy28 with SMTP id 28so501504ewy.28
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 04:34:05 -0700 (PDT)
Received: by 10.213.4.80 with SMTP id 16mr6331628ebq.57.1285241645192;
        Thu, 23 Sep 2010 04:34:05 -0700 (PDT)
Received: from clix.int.op5.se (fw1-sth-pio.op5.com [109.228.142.130])
        by mx.google.com with ESMTPS id u9sm1064647eeh.11.2010.09.23.04.34.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 04:34:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6 ThunderGit/0.1a
In-Reply-To: <AANLkTi=VDmyhUDYKc38bOZWLncZ_twQGB2n5KgbgP_tf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156864>

On 09/23/2010 08:07 AM, Ramana Kumar wrote:
> Are recursive aliases in any way allowed?

They're not just not allowed; they're not even possible.

> What about aliases that don't refer to themselves, but refer to other aliases?
> 

Again, this isn't possible. How could you configure something like that?

> Obviously I can just call git from the shell with a ! alias, but
> wondering if there's any better way.

There isn't. The simple aliases are there to let you run certain
commands with certain default parameters as a new command. Normal
commands have no way of calling other commands (or themselves)
recursively. That's what shell-scripts are for.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
