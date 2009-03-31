From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: strbuf name conflict on Mac OS
Date: Tue, 31 Mar 2009 17:36:40 -0400
Message-ID: <76718490903311436p5fe81ce3k31f18170d9388e8e@mail.gmail.com>
References: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com>
	 <alpine.DEB.1.00.0903312222440.6616@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lolew-0000rW-24
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 23:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbZCaVgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755285AbZCaVgn
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 17:36:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:3204 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbZCaVgm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 17:36:42 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2631346yxl.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nt/7VByTRx6jveff7FLlQI1d/2D31x2G/qdUlHm6Fi0=;
        b=uYXJNyE4EQy3yw0WpoieGxirZaN396TPvHYr8ZqxGRSnfUt3aod0CWqGq87tIu8QjC
         4EetA9i8qD2pj2GUQYBh8B+bu9XbcPHtG2CuicEjCPHMMKYIP93GocFnu1NTgc6SvTa+
         BYh7PhNXRofD4HBNfH5U6Rt0M4179RqSeLw+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nWjxUvRoAijoTyMrsIlVIZzlwqi6yshAwpedVfDoGDhqQErsGwoGz6+ZtUMYh1B7V4
         89yQowY/Tg8zh9rlbAJPXLAN5NdTApduN4VrjXOwXnHY8q7rCA/UA+9XxrFGlH+mUlMn
         5hWsn0+aE6rMtuzgdmc13dthVH1CwU+hvtAzc=
Received: by 10.151.103.11 with SMTP id f11mr3295313ybm.235.1238535400120; 
	Tue, 31 Mar 2009 14:36:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903312222440.6616@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115320>

On Tue, Mar 31, 2009 at 4:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> How about this instead?
> =C2=A0ifeq ($(uname_S),Darwin)
> + =C2=A0 =C2=A0 =C2=A0 BASIC_CFLAGS +=3D -Dstrbuf=3Dgit_strbuf

Heh, wrong platform. See Joshua's other message about porting git to
Mac OS (not Mac OS X). :-)

j.
