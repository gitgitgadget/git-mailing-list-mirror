From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] branch: add support for --dry-run option
Date: Sat, 17 Jan 2015 12:18:19 -0000
Organization: OPDS
Message-ID: <012FBD7D0B7848AC83D6D8C07C6C78EC@PhilipOakley>
References: <1421480159-4848-1-git-send-email-kuleshovmail@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Alexander Kuleshov" <kuleshovmail@gmail.com>
To: "Alexander Kuleshov" <kuleshovmail@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 13:22:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCSOk-0002rr-Sx
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 13:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbbAQMR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 07:17:58 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:43891 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147AbbAQMR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2015 07:17:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmAYAI9SulROl3fXPGdsb2JhbABagwaBKoYvbcUCBAKBEUQBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQIEgYHAxQGARIIAgECAwGIBwMJDMJUiQoNhBwsjU+BRmSDHYETBYlDhQlRhnqNY4VrhBA+MYEDgUABAQE
X-IPAS-Result: AmAYAI9SulROl3fXPGdsb2JhbABagwaBKoYvbcUCBAKBEUQBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQIEgYHAxQGARIIAgECAwGIBwMJDMJUiQoNhBwsjU+BRmSDHYETBYlDhQlRhnqNY4VrhBA+MYEDgUABAQE
X-IronPort-AV: E=Sophos;i="5.09,416,1418083200"; 
   d="scan'208";a="581008831"
Received: from host-78-151-119-215.as13285.net (HELO PhilipOakley) ([78.151.119.215])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 17 Jan 2015 12:17:56 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262585>

From: "Alexander Kuleshov" <kuleshovmail@gmail.com>
> This patch adds support -d/--dry-run option for branch(es) deletion.
> If -d/--dry-run option passed to git branch -d branch..., branch(es)

surely s|-d/--dry-run|-n/--dry-run|
-n is the short version of --dryrun. -d is already in use.

> will not be removed, instead just print list of branches that are
> to be removed.
> 
[...]
--
Philip
