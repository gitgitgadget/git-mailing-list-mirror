From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Sun, 7 Jun 2009 19:25:40 +0800
Message-ID: <be6fef0d0906070425n2be004e4y69d9d9d472ff37ac@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
	 <m3vdnda9f7.fsf@localhost.localdomain>
	 <7vmy8p8947.fsf@alter.siamese.dyndns.org>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 13:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDGXN-0000R6-VV
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 13:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZFGLZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 07:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZFGLZj
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 07:25:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:63530 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbZFGLZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 07:25:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1062828wfd.4
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uNoA/HTdVqPk4bl7MYfIMqijsune9p53WuLMKDynjvU=;
        b=sSAsj2qN6GecnCQLTqnpbqu4f+ct57cqsUduIkBGUJAVD87iQCEBThp7b5yUuEyluB
         MxerOxuBYXMvPioT2guzfoWJsQKfCLPglXtlA3hweMJD+opUhDe02J1cl7orjqJSbWqs
         bPF6Uqaayy+eGxxr4wMXrlY4KAVVcbcG1O9tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IBIm0iV55/eq7pat9KunVyTPEQO7oyJpD0xbDuCYmEgmGJghSgWHscD7X7KgAgHhNx
         c2bmO2ozDtVTd0DxC2KYDmwpDS3lU1B8UNi63DQyTK60z4T0SvVfKLv/AYG1S7krIAdL
         lCQ1EG0y3fxgrZIYXnHQ2YYZK6s/ghNxPMqtk=
Received: by 10.142.49.20 with SMTP id w20mr404120wfw.9.1244373941034; Sun, 07 
	Jun 2009 04:25:41 -0700 (PDT)
In-Reply-To: <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120965>

Hi,

On Thu, Jun 4, 2009 at 8:45 PM, Tay Ray Chuan<rctay89@gmail.com> wrote:
> tries to fetch the raw pack; if it can't be found at the url, or at

Oops, I meant "raw object".

-- 
Cheers,
Ray Chuan
