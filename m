From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation: git-config minor cleanups
Date: Sun, 17 Oct 2010 22:38:33 -0500
Message-ID: <20101018033722.GA3340@burratino>
References: <1287371445-26134-1-git-send-email-cliff@meraki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Cliff Frey <cliff@meraki.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 05:42:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7gc5-0006MJ-63
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 05:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab0JRDmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 23:42:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63122 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0JRDmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 23:42:10 -0400
Received: by ywi6 with SMTP id 6so144062ywi.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 20:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=skpV1sMsgB9v/GnOI6h0+0aLytGcuIuQ/vGpMG80Kfo=;
        b=p4Ppsh0mqV2AQI4vlx/Davzs4YbQ0oI9RkR2aavn0kbDQfYWnvOPFaavJAMzIlSXcl
         P/s9kff1ckXiMLFC22OunebJl0GomcgpxrP/Pr7qlqMVh3KIzDPdF9rwD4gvNKJXPP4q
         Rzpcj9GBcpxG9wElMetT6Dg5THEeFppuSOVDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C+NzknSTGFEGQEn+h2urLhbjl7xilCfHJYvjI45MFf9Wbjlj+tKZLr67j4d8D8Fptb
         oFoV2YXoUZv5ymcWLYU6PQ5pneU4ZacBIXmoND6BbOgHb015D3rP8kPrfzaxDpzkErAa
         rjO6Pb8k3yuTbZ4/p3jhJ53sVp6pv9OJEDHRs=
Received: by 10.236.103.137 with SMTP id f9mr6933677yhg.77.1287373329915;
        Sun, 17 Oct 2010 20:42:09 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id f50sm6503249yhc.38.2010.10.17.20.42.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 20:42:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287371445-26134-1-git-send-email-cliff@meraki.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159229>

Cliff Frey wrote:

> Change push.default's description to add hyphens between values and
> descriptions to make the manpage easier to read.  The html version is
> readable either way.
>=20
> Change status.showUntrackedFiles to make item descriptions be
> sentences and to use the same asciidoc format as push.default.

Yep, it is hard to read

| =C2=B7    nothing do not push anything.
|
| =C2=B7    matching push all matching branches. All
|     branches having the same name in both ends are
[etc]

without the font change to indicate where each term begins and ends.

So for what it's worth:
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1765,9 +1765,9 @@ status.showUntrackedFiles::
>  	the untracked files. Possible values are:
>  +
>  --
> -	- 'no'     - Show no untracked files
> -	- 'normal' - Shows untracked files and directories
> -	- 'all'    - Shows also individual files in untracked directories.
> +* `no` - Show no untracked files.
> +* `normal` - Shows untracked files and directories.
> +* `all` - Shows also individual files in untracked directories.

If you are making these into sentences, they should be

 - Show no untracked...
 - Show untracked...
 - Also show...

, no?  [i.e., s/Shows/Show/c]
