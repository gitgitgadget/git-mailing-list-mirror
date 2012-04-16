From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] tests: add tests for the bash prompt functions in
 the completion script
Date: Mon, 16 Apr 2012 18:50:26 -0500
Message-ID: <20120416235026.GA12613@burratino>
References: <20120416160124.GL5813@burratino>
 <1334614176-2963-1-git-send-email-szeder@ira.uka.de>
 <1334614176-2963-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJvgu-0004YO-8N
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab2DPXuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 19:50:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53867 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab2DPXuf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 19:50:35 -0400
Received: by iagz16 with SMTP id z16so8114993iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tRyezFJgZoUlVbq0nFjsq177aSs0tSlDC/2ekKen2e0=;
        b=rkzmvtQkd9rxJadiORM+pmHM+j+Sp25cQIc9uwc4wI2tStgWNy+7OD2IunMPj0CRsl
         If1ZuYdoHLFiPIK1Iyl83N7Vwv0DRn0NSjorh5c47zsPWDvC8uWaQzxD0DDNBlblrBvr
         s7kV0Ft9c1FKpKRsMgtf+fM1ALc31dF4Bs10FBeiNxeexs3/LSjewwVdR6htOZBTvBru
         k0EgkqbZukekvJSqyJmACqm5lDUaaT7J8ccBwSDlxRHMddYUojzOxv2zs0GTeoF2ZESH
         Rdz1tf3WgC1RPg/QCCBwjeTXkv+LuDA8bdI+T2OlGGobQINUEqA+/optHQZMm4XElzL5
         LSgQ==
Received: by 10.42.130.199 with SMTP id w7mr8407053ics.23.1334620235300;
        Mon, 16 Apr 2012 16:50:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m4sm28950996igw.1.2012.04.16.16.50.34
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 16:50:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334614176-2963-2-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195726>

SZEDER G=C3=A1bor wrote:

>  create mode 100644 t/t9903-bash-prompt.sh

Should be 100755, no?
