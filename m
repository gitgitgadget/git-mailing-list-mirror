From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4] log: add log.follow config option
Date: Thu, 09 Jul 2015 13:38:31 -0400
Organization: Twitter
Message-ID: <1436463511.4542.27.camel@twopensource.com>
References: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
	 <vpqfv4xafpp.fsf@anie.imag.fr>
	 <xmqqegkhw8hf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDFmR-0001Ua-HT
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbbGIRig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:38:36 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34306 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbGIRie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 13:38:34 -0400
Received: by qkcl188 with SMTP id l188so7425351qkc.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 10:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=UeH2oFcm1hro6vNm4B+O+s5gz877TnZ485vISzzwCP8=;
        b=gRykGiRkHXLB6UgHpi1A1p9BQgd6fvBh6GGuzyMB5pAXOXKEIF/H23rUE1l6vLCiBI
         iPaSzozp6Jrh77t/8WHar0gQy33kd3p8DxA8VwpPsXZqo5uZl4YTJB7qi4uOVb9xQqI8
         2dfG8EjvyONyI/AyjqKLB6ih7/alCqfeiWIKEhB3YD0TaEcNPG64f50DbvgG0FWV7vwI
         MqDb78sXFYbLSPQzp2SF1ZGj0DA5pb0GzdGGUKRReQl6kJw9jUa5n69RUBMAMF/MemRa
         SvmlomUPHVSY72y6GQn/WeVD0eGk3RJI/zfxkSIio101WqJJKRI3eXz8PufNrv/2Xz7f
         eVZQ==
X-Gm-Message-State: ALoCoQne/hmgVmUf/KVDy/lW8Js3dOrax2Hh6qPsQ1tUeSheUtFJEhEOBuwvAnj0AoSF0TTUDyeP
X-Received: by 10.140.28.247 with SMTP id 110mr15128095qgz.16.1436463513917;
        Thu, 09 Jul 2015 10:38:33 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b133sm3913804qhc.40.2015.07.09.10.38.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 10:38:32 -0700 (PDT)
In-Reply-To: <xmqqegkhw8hf.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273763>

On Thu, 2015-07-09 at 10:23 -0700, Junio C Hamano wrote:
<snip>
> If I were David and sending this v4 patch, it would have looked like
> this.
>
> -- >8 --
> 
> From: David Turner <dturner@twopensource.com>
> Date: Tue, 7 Jul 2015 21:29:34 -0400
> Subject: [PATCH v4] log: add "log.follow" configuration variable
> 
> People who work on projects with mostly linear history with frequent
> whole file renames may want to always use "git log --follow" when
> inspecting the life of the content that live in a single path.
> 
> Teach the command to behave as if "--follow" was given from the
> command line when log.follow configuration variable is set *and*
> there is one (and only one) path on the command line.


Thanks.  That version is much better.
