From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3] help (Windows): Display HTML in default browser using Windows' shell API
Date: Fri, 11 Jul 2008 09:35:36 +0200
Message-ID: <228FC26D-D318-487A-9BF3-B473096CB0C9@zib.de>
References: <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de> <1215761286-2489-1-git-send-email-prohaska@zib.de> <1215761286-2489-2-git-send-email-prohaska@zib.de> <1215761286-2489-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHDBZ-0005GR-9Y
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 09:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYGKHfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 03:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYGKHfx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 03:35:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:50223 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbYGKHfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 03:35:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6B7ZAlh015059;
	Fri, 11 Jul 2008 09:35:15 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6B7Z9t2001414
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jul 2008 09:35:09 +0200 (MEST)
In-Reply-To: <1215761286-2489-3-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88092>


On Jul 11, 2008, at 9:28 AM, Steffen Prohaska wrote:

> +
> +static const char *make_backslash_path(const char* path) {
> +	static char buf[PATH_MAX + 1];
> +	char* c;

Style :-(.  I'll send a fixed patch in a minute.


> +#ifndef open_html
> +void open_html(const char* path)
> +{

It'll fix this too.

	Steffen
