From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Mon, 18 Aug 2008 19:23:51 -0400
Message-ID: <48AA0487.8050009@gmail.com>
References: <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net> <20080818061236.GF7376@spearce.org> <20080818230646.GA11044@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:25:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVE5r-0006zS-Qk
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbYHRXX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYHRXX4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:23:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:43815 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbYHRXXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:23:55 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2297216wri.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 16:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=/7SQOrixZAdJhR/D4r2H2WNjnlDkhBMGPL57DDEJSy0=;
        b=GY/3pExqXbZJb0Nm51AnxStd/xoDRuanYsi4+WKPMt9PL8sprHHoOFug+4yGeHKMoC
         cLCWFt3O2lmnD6W483E9Z1q2vSvppMKsgTtsWWmjVCi9M8o7eiBQbdANBIIr0hKqOyMp
         EevyUHrvtm2nCgnAtdoAPdRK1f2OIi3VTMuOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=fd3qvrC2aPmgs8/74TtxmQGFiX3JyXnqXyIKmbnlssN37B1YTNn6Jy3Uxjq6X7xnv8
         7zD/PoKxiyPVv3J/kwQ2W7WiokqpIt2N2Y0bXRb/e61k2GULwsNZtmssZ4jLxiQFudGj
         hvQ/axaN9/tQK0A98ThN57RKEZuQtV47JS754=
Received: by 10.90.69.7 with SMTP id r7mr8621260aga.99.1219101835088;
        Mon, 18 Aug 2008 16:23:55 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 18sm736192agb.12.2008.08.18.16.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 16:23:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080818230646.GA11044@cisco.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92759>

Derek Fawcus wrote:
> My other hacky thought was that tag object could be overloaded for
> this purpose.  It is already sort of an indirect object,  but seems
> to be limited to appearing at the edge of the graph.
>=20
> If we could say have:
>=20
>   commit -> tag -> tree
>=20
> then arbitrary data could be stored in the tag,  similarly this
> could be extended for when a tree or blob object is expected
> (I'm not sure about the blob case).

I was under the impression that tags were references to commit objects,
and they to tree objects:

tag -> commit -> tree

Also, wouldn't this require large numbers tags, or the ability to multi=
-
target tags?

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
