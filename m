From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [StGit PATCH 2/2] Implement "stg refresh --edit" again
Date: Fri, 4 Jul 2008 09:32:54 +0200
Message-ID: <200807040932.56166.jnareb@gmail.com>
References: <20080704063755.9637.23750.stgit@yoghurt> <20080704064036.9637.52951.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 09:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEfoP-0000NF-EA
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 09:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbYGDHdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 03:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbYGDHdf
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 03:33:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:64106 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652AbYGDHde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 03:33:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1413877rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QjylIRgBR3Y1NOaJ+33GU/2DBmViZtmGFibPuXA7OwQ=;
        b=O0OT2ZUQc7KBwqp9yyc7mU8ej9MoBHm98tYCmNmAtkDWynwL0kUhTK/HLneaWu3GnI
         4YTNRVuunpxEZZcWfmmDplVCw5c1Frmn5XGmZVNm8787KC++TUc3r+tBUR/14jCQdeov
         kBdFTkkPlS3gE+CI/ZhZgo7Q8LFQ3jJBiqrck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WYwhg8kqLTtCKMlPwSJWnNc5Oic0ioLko2FDvAQYF7p5Kl8Snptb1bkbpmkn/QokNR
         6ON47fe+szdEm/SuGsDGQrLFW3k5lm0xjKBYc+p/39dvrswq1qs80t9izNgpQB1cQ+z9
         F3l8Wis11EQQrq2ev2HTScqO9r8ZhMvvFOJac=
Received: by 10.114.180.1 with SMTP id c1mr2983750waf.85.1215156813557;
        Fri, 04 Jul 2008 00:33:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.222.3])
        by mx.google.com with ESMTPS id 4sm1382808fge.5.2008.07.04.00.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 00:33:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080704064036.9637.52951.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87371>

Karl Hasselstr=C3=B6m napisa=C5=82:

> The -e/--edit flag to "stg refresh" was dropped between v0.13 and
> v0.14, causing severe user dissatisfaction. This patch restores it

Thanks a lot!
--=20
Jakub Narebski
Poland
