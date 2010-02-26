From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with
 GIT_ASKPASS
Date: Fri, 26 Feb 2010 01:50:20 +0100
Message-ID: <20100226005020.GR12429@genesis.frugalware.org>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zz3/bjUB5SIr1k9f"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:50:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkoPf-0002jg-MK
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934755Ab0BZAu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:50:29 -0500
Received: from virgo.iok.hu ([212.40.97.103]:59366 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934792Ab0BZAu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:50:26 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F327A58070;
	Fri, 26 Feb 2010 01:50:20 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A76A742F09;
	Fri, 26 Feb 2010 01:50:20 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 91FFE1240003; Fri, 26 Feb 2010 01:50:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141087>


--zz3/bjUB5SIr1k9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2010 at 08:12:34AM +0800, Frank Li <lznuaa@gmail.com> wrote:
> +		for (i = 0; i < buffer.len; i++)
> +			if (buffer.buf[i] == '\n' || buffer.buf[i] == '\r') {
> +				buffer.buf[i] = '\0';
> +				buffer.len = i;
> +		}
> +		return strbuf_detach(&buffer, NULL);
> +
> +	} else {
> +		return getpass(prompt);
> +	}

According to Documentation/CodingGuidelines, this would be:


		for (i = 0; i < buffer.len; i++)
			if (buffer.buf[i] == '\n' || buffer.buf[i] == '\r') {
				buffer.buf[i] = '\0';
				buffer.len = i;
			}
		return strbuf_detach(&buffer, NULL);

	} else
		return getpass(prompt);

--zz3/bjUB5SIr1k9f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuHGswACgkQe81tAgORUJYLZgCeI/fWZHDzPbu8/YcPyGdRPy9n
KHIAn1e3J+yObzPSDiU7wf3H8R6pIcMh
=lkcx
-----END PGP SIGNATURE-----

--zz3/bjUB5SIr1k9f--
