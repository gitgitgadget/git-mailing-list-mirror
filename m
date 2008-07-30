From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 11:58:57 -0400
Message-ID: <32541b130807300858r152d7428j404eaefc04f606@mail.gmail.com>
References: <20080730133859.368bbd92@pc09.procura.nl>
	 <20080730133334.GB31192@lars.home.noschinski.de>
	 <20080730155835.71289eee@pc09.procura.nl>
	 <20080730145534.GD32057@genesis.frugalware.org>
	 <20080730170326.6f4f1772@pc09.procura.nl>
	 <8aa486160807300823w3dfbdff2m4b9821d71779231d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOE5w-0002oC-8F
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 18:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbYG3P7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 11:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYG3P7A
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:59:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:56355 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbYG3P65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 11:58:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so79208rvb.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=v38gg+4xewSekxdUY502kYXK4sfakfK5YfTxKYZDtbo=;
        b=b4yF8oejDPura+SbyVBs94bxpeCGiO5mIsTvsOoSJgCd3McSBejnpETE3b8OKSku++
         WpdafTPNcY1jyNCJSw+nOimu09uLAyGfsqnf8TERXfsV0d4SC+MgYUBTGvEVgeuBlrlW
         9Ile1/Ba5DsiwI7NjT3B8BUfnkCpIYL4A3w5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GwnUWTXV+/pv+LP1dXZbHyM1Qr/QoVgO+crD5K0wLYp/gQ7YKEsYzJZt2pfh/XkI0V
         v85u7PY0HKWwtUHJ9gE40FHziTrHhPNfpERlMSDZfnHNs8NXImcDuF3bcSV3xZsDG5U6
         5/0Rc9UwsWQ603sBZ5EVBuCCB4zJs4CRHkiQA=
Received: by 10.141.49.6 with SMTP id b6mr4456500rvk.223.1217433537162;
        Wed, 30 Jul 2008 08:58:57 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 30 Jul 2008 08:58:57 -0700 (PDT)
In-Reply-To: <8aa486160807300823w3dfbdff2m4b9821d71779231d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90811>

On Wed, Jul 30, 2008 at 11:23 AM, Santi B=E9jar <sbejar@gmail.com> wrot=
e:
> It cannot be described because there is no annotated tag before this
> commit. Add --always to show the abbreviated commit as fallback.

Or --tags to include non-annotated tags.

Avery
