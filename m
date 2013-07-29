From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Mon, 29 Jul 2013 20:16:03 +0200
Message-ID: <51F6B163.8000605@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net> <51F3A358.5000807@gmail.com> <720060083F5C476A905C09146E7CD711@PhilipOakley> <51F3B2D1.2040402@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <stefanbeller@googlemail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rzT-0007yJ-43
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab3G2SQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:16:11 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:63925 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3G2SQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:16:10 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so401357eae.37
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7xXfPQE+1882rFlffAj8liN03Cj2EpwI+P03TEXl3vg=;
        b=qpruXQUxgANPu3hN0b1ZVbwz0AM1lyReDvlsoYmPo68w8d3ptkf8E+YX3BmS02EKML
         Lt0wLRFdX2AcPvO4zxY0gzR7BnY2am8PCl5bGrkGnHqNl4VAJUpCiEDKrX+ANEqMVCuB
         CYTIU1CPGQN01jd66VODGNEqTr1NqnfU9RYvzH4aXQofTA3zowkeL8JuiG35HrC6xL+i
         fotzViQTZeQjt7NPpRqS2TUpLljpFrz/9MWju/oOrpiiCXFBXxUANz6Q3ssQMqn0mgzA
         yDHF/3s5X/26MMLtbYP6IAKAAfgd7U/38SEwhsAsZXXdh2SZHInrr3ZDQkVNTfM/G5OA
         aWEg==
X-Received: by 10.15.36.133 with SMTP id i5mr61365491eev.52.1375121769200;
        Mon, 29 Jul 2013 11:16:09 -0700 (PDT)
Received: from [192.168.1.16] (host253-69-dynamic.4-87-r.retail.telecomitalia.it. [87.4.69.253])
        by mx.google.com with ESMTPSA id ci50sm103784520eeb.12.2013.07.29.11.16.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 11:16:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F3B2D1.2040402@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231314>

On 07/27/2013 01:45 PM, Stefan Beller wrote:
> On 07/27/2013 01:26 PM, Philip Oakley wrote:
>
>> Try 'git format-patch' and 'git send-email'. The format-patch man page
>> even has a note about Thunderbird corruptions.
>>
>> Philip
>>
>
> Well I use Thunderbird as well for regular communication except for
> sending patches.
> The kernel documentation has also some words about Thunderbird
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/email-clients.txt
>
> Given so many steps, I also configured git send-email, which makes
> sure that patches are uncorrupted.
> For gmail add these lines to your ~/.gitconfig
>
> [sendemail]
[snip]

>
> Then you'd need to have msmtp installed and have the following
> in the file ~/.msmtprc
[snip]
>
> I think it would also work without having git relying on msmtp by now,
> but I'd be too lazy to change my existing working setup.
>

Hi Paolo, Philip, Stefan,

thank you, you've been very kind.
I think I've set it up, I'll try with the next patch, if any!

Regards,
Daniele Segato
