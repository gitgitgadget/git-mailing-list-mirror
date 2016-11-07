Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A46B2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 13:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbcKGNQW (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 08:16:22 -0500
Received: from sgc-chev-fe1.sgc.gmessaging.net ([194.51.18.91]:64803 "EHLO
        sgc-rueil-fe1.sgc.gmessaging.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753244AbcKGNQG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2016 08:16:06 -0500
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Nov 2016 08:16:05 EST
Received: from sgc-rueil-fe1.sgc.gmessaging.net (localhost.localdomain [127.0.0.1])
        by localhost.sgc.gmessaging.net (Postfix) with SMTP id 3tCCRL0hvVz3BmCR
        for <git@vger.kernel.org>; Mon,  7 Nov 2016 14:07:58 +0100 (CET)
Received: from EXDRUEARSGC002.eq1sgc.local (unknown [10.67.4.132])
        by sgc-rueil-fe1.sgc.gmessaging.net (Postfix) with ESMTP id 3tCCRK6clPz3Bm9s
        for <git@vger.kernel.org>; Mon,  7 Nov 2016 14:07:57 +0100 (CET)
Received: from [10.66.239.4] (10.66.239.4) by webmail-int.sagemcom.com
 (10.67.4.132) with Microsoft SMTP Server (TLS) id 14.3.279.2; Mon, 7 Nov 2016
 14:07:57 +0100
Message-ID: <58207CAB.3060105@sagemcom.com>
Date:   Mon, 7 Nov 2016 14:07:55 +0100
From:   Alexandre Duplaix <alexandre.duplaix-ext@sagemcom.com>
Organization: Sagemcom
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     <git@vger.kernel.org>
Subject: Forbid access to /gitweb but authorize the sub projets
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.66.239.4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have several projects under https://myserver/gitweb and I would like 
to forbid the access to the root, so that the users can't list the 
differents projects.

However, I need to let the access to the sub projects (ex: 
https://myserver/gitweb/?p=project1;a=summary

How can I do please ?

Thank you in advance :)

" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caractère privé. 
S'ils ne vous sont pas destinés nous vous signalons qu'il est strictement interdit de les
divulguer, de les reproduire ou d'en utiliser de quelque manière que ce
soit le contenu. Si ce message vous a été transmis par erreur, merci d'en
informer l'expéditeur et de supprimer immédiatement de votre système
informatique ce courriel ainsi que tous les documents qui y sont attachés"

                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachments
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise the
sender immediately and delete this e-mail and all attached documents
from your computer system."
#

