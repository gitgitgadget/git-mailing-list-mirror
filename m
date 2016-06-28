Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AAD1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbcF1IFg (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:05:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56571 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbcF1IEy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 04:04:54 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue104) with ESMTPSA (Nemesis) id
 0Mddka-1azBE92syC-00POLT; Tue, 28 Jun 2016 10:04:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 66297B0172E;
	Tue, 28 Jun 2016 10:04:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id geJUWXbQguj3; Tue, 28 Jun 2016 10:04:27 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id 5353EB016DF;
	Tue, 28 Jun 2016 10:04:27 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Tue, 28 Jun 2016 10:04:27 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 D8066804B0; Tue, 28 Jun 2016 10:04:26 +0200 (CEST)
Date:	Tue, 28 Jun 2016 10:04:26 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:	<git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for $FILENAMES in tool definitions
Message-ID: <20160628080426.GB3710@pflmari>
Reply-To: Alex Riesen <alexander.riesen@cetitec.com>
References: <20160627132137.GC4194@pflmari>
 <alpine.DEB.2.20.1606271748250.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1606271748250.12947@virtualbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: avast! (VPS 160627-1, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K0:xQa9TzBl0dMXt8ZplUhcbKejBq26hW6sJns2QhwnlnBhrgiLQoB
 tNagP71ckAzghr9Tac3epYXax4tUHxXot+sjdacxzkU/fpHv2l7fy/UgxTKnQzKsAzYsSO8
 wuMivKG8xswJs8qRf9Lk72uJ+ZB1OULaICqmO6p5t6Lu0FwzWJAeWYegx6V7ynVM0SiM4eH
 FdiIsmxaGtxoaHdYt1gZg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XqB+/XqPp/I=:jOEASQkj9TQ0CTUBHEYYJd
 X1XaTVjWrJ92Qr2YigCknWigt0euabvUcqLw/jxvB59skon1H6JR/1KDf47nMPUc9Qvg8dVYq
 n1/GhJ5QBVHvN1Ab7FI061+AIqTEihK5zILWGxp02B8YOoqfF9Q+uch3QYcee/CV1dF2fGc4h
 2ldrbZFwj/SbVn0rwmQ2mK0n8juxrq+kG35emfQgpFxqdM5ArC/Kg3dax3uu9elwiaoOZfLla
 IotCMi+PHab/GKz8FE4a2X5IDoXaUwEz7nJ9Z3u4IF1VmPGrvZeV0LhwKwWDWOXpQMki02qJG
 73VCD7bfP4jr72n/diD1PJyREy+QehRu9ecOugxqHmtYupeQ/Iuj3ncDw7ZoH06sXSPJ+HVKQ
 r1aQGCp8317SYzaOXEfu9Er0ySTwHnBtOMptzZi0QDP8uq1wudpMgdwvwuprpQM2jEodDsLXY
 8X31YdOawxwJaWZXPq43spX+UpgVfCH7wMupc9f79QjXg62vnQjSKb0V3M9tAwklS1079CY2v
 9svCOUqAxGL65lvLqJnhEFUZFiEpr56RjEfvAMS0fkU0LFvzFRxzOLFVgiBKqQizS98ABFlRc
 OvvjLCzxMAaotwAYR9qcBW6NCgIhv33xazRw1ZiA2zhmqX7BAIa0PxrXFW0G2aWJhi+jsHUDO
 gW87Cbk6SRPZrdCEHNfwmecpq48VaitdZi/EWanoQmsOY1xfNCwQOv7idgx4x+99Lixg=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin, Mon, Jun 27, 2016 17:49:30 +0200:
> On Mon, 27 Jun 2016, Alex Riesen wrote:
> 
> > This adds a FILENAMES environment variable, which contains the repository
> > pathnames of all selected files the list.
> > The variable contains the names separated by spaces.
> > 
> > Similar to the FILENAME it is broken yet, if the names contain spaces.
> > 
> > Note that the file marked and diffed immediately after starting the GUI up,
> > is not actually selected. One must click on it once to really select it.
> > 
> > Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> 
> Maybe prefix the subject with `git-gui: ` to indicate that this is for the
> git-gui.git repository?

Done.

> Also, please muster some patience, Pat seems to be super busy these days.

It's alright. Nice to know he's ok, though.

Regards,
Alex


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

