From: Andreas Ericsson <ae@op5.se>
Subject: Re: Completion of error handling
Date: Tue, 16 Feb 2010 11:56:48 +0100
Message-ID: <4B7A79F0.1070100@op5.se>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> <4B740153.4010600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 16 11:57:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhL6x-0007HG-Bx
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab0BPK4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:56:54 -0500
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37748 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751030Ab0BPK4x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 05:56:53 -0500
Received: from source ([209.85.219.223]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS3p587S/Iitt+RZHzNAKRy6kkNuzWa6z@postini.com; Tue, 16 Feb 2010 02:56:52 PST
Received: by ewy23 with SMTP id 23so331246ewy.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 02:56:50 -0800 (PST)
Received: by 10.213.68.13 with SMTP id t13mr1277481ebi.62.1266317810768;
        Tue, 16 Feb 2010 02:56:50 -0800 (PST)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 15sm5076414ewy.8.2010.02.16.02.56.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 02:56:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1 ThunderGit/0.1a
In-Reply-To: <4B740153.4010600@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140095>

On 02/11/2010 02:08 PM, Markus Elfring wrote:
> 
>>
>> What is the likelihood for those function calls to actually fail?
>>
> 
> How do you think about the usual design choices that are described in
> the article "Exception Handling Alternatives" by Detlef Vollmann.
> http://accu.org/index.php/journals/546
> 

That's an awful lot of text to read that's hardly relevant for a C
program. Most of it regards newbie stuff about how to handle reporting
an error when you can't use a C++ exception.

> 
> I propose to write pointcuts for all functions that can return values.
> Some corresponding error codes are checked already. But there a places
> in the source files with open issues for complete software robustness.
> 

You keep on claiming that but haven't proven it in any way. If you
could point out a real bug I'm very, very certain it would be fixed
within 24 hours.

> Are there any chances to encapsulate more cross-cutting concerns as
> reusable aspects?
> 
> Would you like to integrate tools like the following into your software
> development process?
> - AspectC++
>    http://aspectc.org/
> 

Git is written in C, not C++. Using aspectc++ would mean requiring
the use of a C++ compiler, which git doesn't require today. That's
one step backwards in portability which I seriously doubt the
usefulness of aspectc++ can outweigh.

Now please stop trolling and find one of these bugs you keep talking
about but never showing. We've made it painfully clear to you that
we're interested in realworld problems rather than potential ones,
so all this "use this model for development" just reeks of concept
evangelism. No real engineer likes that, which is why you're facing
such massive opposition on this list.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
