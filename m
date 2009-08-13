From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 10:28:55 -0700
Message-ID: <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com>
References: <1250140186-12363-2-git-send-email-srabbelier@gmail.com> 
	<20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> 
	<20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbe7D-0001LG-1U
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbZHMR3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 13:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbZHMR3Q
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:29:16 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:51526 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZHMR3Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 13:29:16 -0400
Received: by ey-out-2122.google.com with SMTP id 22so185495eye.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=f03d06f3F91WdUY0+C7vMXpqZdrliRPVUdy1Npuq+SY=;
        b=j73ER4v2k9jIHNLLr6bUAxgdUdavs3lfWmMfL6xW9Nk80tIczwX+gyBWwBfapmLnqF
         O88GicrqIhtkpu40ompNhmeI73NrOEqwAypjQYo9WQtfX3mK8Z242qdV8vzm8VHjOl+o
         NpOlxwVRVw6Qb7SyjLuNbArBqxNcO7m/iUvIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lDBxBPl2Y6VZGkLUu4rkkJjAh68ntERoBemUVL1KY7ICYHKxKCQbF0YypmiVJkZBrl
         V+jqMmseapVkDnQstXUP/VSBNV2Xht7wfmVAjZx464ZmP24xORHF9gZ3mu6W9hgxR75k
         PX4tMGt2jFJuEFuOnovPIeowCM//TxMhk+Kh0=
Received: by 10.216.11.72 with SMTP id 50mr211442wew.64.1250184555416; Thu, 13 
	Aug 2009 10:29:15 -0700 (PDT)
In-Reply-To: <20090813172508.GO1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125844>

Heya,

On Thu, Aug 13, 2009 at 10:25, Shawn O. Pearce<spearce@spearce.org> wro=
te:
> I want this to work, even though /not/found does not exist, but
> my.marks does. =A0So that does complicate things...

Should we pass an option to parse_marks to make it ignore a
non-existing file, and set that option when parsing the stream
commands?

--=20
Cheers,

Sverre Rabbelier
