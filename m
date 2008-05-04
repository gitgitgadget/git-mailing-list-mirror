From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update". "file.txt: has changes" is much clearer.
Date: Sat, 3 May 2008 20:21:53 -0400
Message-ID: <32541b130805031721n29cf470cx391fe0e8b4943706@mail.gmail.com>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
	 <alpine.DEB.1.00.0805031509170.30431@racer>
	 <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
	 <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com>
	 <7v63tvszgo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim Harper" <timcharper@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 02:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsS0K-0006Xz-Oy
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 02:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYEDAV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 20:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYEDAV5
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 20:21:57 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:20132 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYEDAV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 20:21:56 -0400
Received: by fk-out-0910.google.com with SMTP id 18so128997fkq.5
        for <git@vger.kernel.org>; Sat, 03 May 2008 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VLBZ+V/3Afwbf6f0cVuBmR4HxXers9XoG1eM15U4xRI=;
        b=AUZ6KAziLzJqSBdrOmHp0AKhpb/YWKe72TCaoBZISMlVhMEpIJdT5XpOMZlA8qquarr6MOMOP7dBv4BtlwlSJXJeWe0PF0lRsSFAeFKGix/fAXXX3WPO0ix362/lDkLLC9777aXHg6Zq8moXx1wEEzxZScN7j22pIQDF95Q841I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C1dQ8K5K0Ewkra275COdCOI38qrRY/ZD9jTBGi+Fq9AIBnbg8U1bSmyx1m43VdGj3511sK1pgrSvIP+Ap6mzPqkEytSAvLJQWklFGYR5YlQEc/r/yGTqzqosbPW87kdXUYbDEO9oFJTvvTx6bspW/uMRXeCZiZHGFqW6sVk2Io8=
Received: by 10.82.113.6 with SMTP id l6mr443220buc.17.1209860513570;
        Sat, 03 May 2008 17:21:53 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Sat, 3 May 2008 17:21:53 -0700 (PDT)
In-Reply-To: <7v63tvszgo.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81122>

On 5/3/08, Junio C Hamano <gitster@pobox.com> wrote:
> > I ran all of the tests with the patch apply, and they all pass.  Is
>  > that enough indication?
>
> Of course not.  Where does end-user scripts come into play when you are
>  running the testsuite?

I thought user scripts weren't supposed to rely on the porcelain
output?  It seems to change rather frequently anyway.

Avery
