From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH] [RFC] Add a new config. option for skipping merges in
 git-log
Date: Mon, 16 Mar 2015 21:59:44 +0100
Message-ID: <55074440.90709@posteo.de>
References: <5506E751.8010506@posteo.de>	<xmqqpp88rfq0.fsf@gitster.dls.corp.google.com>	<5507301B.2060401@posteo.de> <xmqqy4mwpsyn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:00:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXc7t-0008PJ-If
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 22:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbCPVAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 17:00:37 -0400
Received: from mx02.posteo.de ([89.146.194.165]:43913 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbbCPVAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 17:00:36 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 9E7CE1EB2F9F;
	Mon, 16 Mar 2015 22:00:34 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l5VQV0Ly6z5vNH;
	Mon, 16 Mar 2015 22:00:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqy4mwpsyn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265595>



On 03/16/2015 09:50 PM, Junio C Hamano wrote:
> The command line overrides the config, no?  If you set up what the
> command line defaults to from the config, let the command line
> parser do whatever it wants to do, and do nothing else after the
> command line parser returns, wouldn't that be sufficient?
> 
> Puzzled...
> 

Yes, the command line overrides the config. But, the config and command
line parameters are parsed in two different files. The question is how
you would read the config in revision.c while parsing the command line
when there is no function in revision.c for that?

Sorry if I look baffled.
-- 
Koosha
