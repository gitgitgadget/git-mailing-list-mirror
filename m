From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/3] http*: refactor fetching code (v2)
Date: Wed, 20 May 2009 20:10:10 +0800
Message-ID: <be6fef0d0905200510w612d6dd0k7948a3194e6f7c15@mail.gmail.com>
References: <20090518163025.58842505.rctay89@gmail.com>
	 <20090520074352.GC21455@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed May 20 14:16:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6kj9-00017I-FK
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 14:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304AbZETMQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757067AbZETMQq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 08:16:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:45717 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757289AbZETMQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 08:16:45 -0400
Received: by wa-out-1112.google.com with SMTP id j5so89339wah.21
        for <git@vger.kernel.org>; Wed, 20 May 2009 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AUeyWNp8M+jhm69WmhpC9oN8rNGeXUAVV/O9jQLNAVo=;
        b=fb/mMr6IHBe6aHysN2Of1yZX/LkGWU+jqqnx3J0VvsqDc4vxwIFXc+PF56+c6LnV8E
         c8qdsh8t0CDksdK8dLxj93B3GQDqlnRO1SgNMbAbwkniB/pst5k3QN5tjY+uEQf8XwFP
         /TGeY84bqXtikpA7vNkaV6QMgT2TvF1j6cwTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f1YHbit40MHkaJ3wlq5BKPYRUbF7ZbLkYQuHdUqRafaZ5EOc1X3m6yJvuk+oCQegLT
         BFPi3ieTo5s0HCH3FlvDsNfSoRuz97vYommjERomWAlTUxyrUMBwwuhR74bslwnL5C3U
         tdFtM5svY0kKooMgSEd/KLzZWBtufKyDJmQd4=
Received: by 10.114.181.6 with SMTP id d6mr2614156waf.8.1242821410325; Wed, 20 
	May 2009 05:10:10 -0700 (PDT)
In-Reply-To: <20090520074352.GC21455@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119607>

Hi,

On Wed, May 20, 2009 at 3:43 PM, Mike Hommey <mh@glandium.org> wrote:
> I do think these would be even better if they were integrated with
> http://kerneltrap.org/mailarchive/git/2009/1/18/4757804.

yes, I agree very much with your proposed http API, with methods for
fetching to files and strbufs. Please think of my patch series as an
intermediate step for your patches, by reducing the amount of code
involved in this API-ish refactoring.

I'm presently working on this.

-- 
Cheers,
Ray Chuan
