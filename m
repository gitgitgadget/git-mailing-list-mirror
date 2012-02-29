From: Andreas Ericsson <ae@op5.se>
Subject: Re: Tilde spec - befuzzled
Date: Wed, 29 Feb 2012 10:32:06 +0100
Message-ID: <4F4DF096.9050905@op5.se>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se> <87zkc38a3v.fsf@thomas.inf.ethz.ch> <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, Luke Diamand <luke@diamand.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:32:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ftR-0000ng-Js
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103Ab2B2JcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:32:12 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40839 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755063Ab2B2JcJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 04:32:09 -0500
Received: by lahj13 with SMTP id j13so3330212lah.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 01:32:08 -0800 (PST)
Received-SPF: pass (google.com: domain of exon@op5.com designates 10.152.114.74 as permitted sender) client-ip=10.152.114.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of exon@op5.com designates 10.152.114.74 as permitted sender) smtp.mail=exon@op5.com
Received: from mr.google.com ([10.152.114.74])
        by 10.152.114.74 with SMTP id je10mr18682102lab.40.1330507928037 (num_hops = 1);
        Wed, 29 Feb 2012 01:32:08 -0800 (PST)
Received: by 10.152.114.74 with SMTP id je10mr15590347lab.40.1330507927952;
        Wed, 29 Feb 2012 01:32:07 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id v4sm23543784lbx.13.2012.02.29.01.32.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 01:32:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnS10PU2Irw9cttca+3dkHzWFtjNNZ5rwdT1kzSoeb82J5umBfLS5Zru0wqL+dx6JlogTem
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191827>

On 02/28/2012 08:20 PM, Junio C Hamano wrote:
> Thomas Rast<trast@inf.ethz.ch>  writes:
> 
>>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>>>> A suffix '{tilde}<n>' to a revision parameter means the commit
>>>> object that is the<n>th generation grand-parent of the named
>>>> commit object, following only the first parents.
>>>>
>>>> Hang on, *grand*-parents?
>>>> ...
>>
>> Perhaps we should reword it as "n-th first-parent ancestor"?  Barring
>> confusion about the position of the dashes, that leaves little room for
>> error.
> 
> I think we could either go "easier to read but not precise"
> 
> 	... that is the<n>th generation (grand-)parent of ...
> 

(grand-)parent and ancestor are interchangeable while the parentheses
remain, although the former looks a bit clumsier in text.

> or "may sound scary but correct"
> 
> 	the ancestor reached by walking the first-parent chain<n>  times
> 
> I am not sure which bucket "n-th first-parent ancestor" falls into.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
