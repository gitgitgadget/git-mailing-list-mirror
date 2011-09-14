From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 23:51:27 +0100
Organization: OPDS
Message-ID: <E9E05FA85D0F4461BAE9ECAFE25CD84E@PhilipOakley>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <vpqfwjzxu6i.fsf@bauges.imag.fr> <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com> <201109141814.04752.johan@herland.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johan Herland" <johan@herland.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:27:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yra-00024C-NO
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab1INX10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:27:26 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59825 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537Ab1INX1T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 19:27:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAD43cU5cHlT4/2dsb2JhbABCiiGdI3mBTgEEAQEFCAEBDiAeAQEhCwIDBQIBAxUMJRQBBBoGBxcGARIIAgECAwEKh1QKtBqGDmAEhz6dJw
X-IronPort-AV: E=Sophos;i="4.68,383,1312153200"; 
   d="scan'208";a="365393775"
Received: from host-92-30-84-248.as13285.net (HELO PhilipOakley) ([92.30.84.248])
  by out1.ip01ir2.opaltelecom.net with SMTP; 15 Sep 2011 00:27:17 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181411>

From: "Johan Herland" <johan@herland.net>
.
> _that_ SHA1. As I said, that _can_ be done with the notes
> infrastructure, but - as Ted noted - there might be better solutions to
> storing branch descriptions.
>
Is one option to store the branch description (if any) on line two of the 
<branch name> file in .git\refs\heads.
That is, from byte 42 onward, after the 40 byte sha1 and its LF.
Older systems would simply overwrite it, while newer systems would be able 
to read it. The fixed format of the first 41 chars alllows sensible checks 
in the various places it is used.

Philip Oakley 
