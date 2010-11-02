From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Tue, 02 Nov 2010 14:42:48 +0100
Message-ID: <4CD01558.7030701@web.de>
References: <cover.1287690696.git.trast@student.ethz.ch> <20101022155307.GB5554@sigill.intra.peff.net> <201010251444.08780.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 14:44:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDHA7-0001aP-2r
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 14:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab0KBNoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 09:44:11 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:36365 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab0KBNoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 09:44:08 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 81BBA16CC65A3;
	Tue,  2 Nov 2010 14:42:49 +0100 (CET)
Received: from [93.246.52.168] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PDH8T-0006Ny-00; Tue, 02 Nov 2010 14:42:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <201010251444.08780.jnareb@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/9Pr4vYTWSQHgw/G21VSoeflmt9IuTdqrTEfjo
	OC4uNr63QlA1zRg6uKMTsSm/t/8cYkvf332117uA6UoprGqWxY
	KxGKaUNyAgHpNaI9a6Ug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160519>

Am 25.10.2010 14:44, schrieb Jakub Narebski:
> 1. Without checking for CONFIGURATION sections, we have what are 
>    probably false positives from gitmodules.txt:
> 
>      submodule.<name>.path::
>      submodule.<name>.url::
>      submodule.<name>.update::
>      submodule.<name>.ignore::
> 
>    I say *probably* because while gitmodules manpage describes those 
>    variables as going into .gitmodules, if I understand it correctly
>    those variables can got to .git/config as an override.

AFAICS only 'path' won't show up in .git/config. 'url' and 'update'
are copied into .git/config by "git submodule init", 'ignore' might
be added by a developer to override the setting from .gitmodules.
