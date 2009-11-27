From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: simplify guess_merge_tool()
Date: Thu, 26 Nov 2009 19:22:35 -0800
Message-ID: <20091127032234.GA2497@gmail.com>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com> <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx> <20091123112221.GA7175@sajinet.com.pe> <7vtywlyu43.fsf@alter.siamese.dyndns.org> <4B0B185B.4090305@lsrfire.ath.cx> <4B0B1ACD.6000008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 27 04:22:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDrPF-0005pE-ND
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 04:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbZK0DVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 22:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbZK0DVo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 22:21:44 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:40471 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZK0DVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 22:21:43 -0500
Received: by gxk26 with SMTP id 26so1062051gxk.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 19:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kxixQyEeWU7fWarQwOqrjhjE6vsQLNL/FrLNqtaoPtI=;
        b=mr0NsxlEowsITxDmFg2U7t+9sO607XroXrQAcqkP2p7Isbw5C9LiwxmFmeV858AAzY
         zLb85pcT08fK94aDE1NL0HAbrF1Rgvv903/cz8zZDXpullIG4BBFNEg2JfqtCIZTAlcw
         yWlCeq6DnZ/M8FXtemn6bV9BJl6ADH6PV4mwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iG/ToXghFnPTfH2uvZDujvWYW0JJarLX0c1kQl9O4hfaH86HK1g70FPjN+8Ihh0GaB
         36lRtO91lTn74tCSsG8w08Ui/l6+VBUeY/rJN/qvJ5w7nRC1bTjD9b0nvaiJmDxbqd12
         6KKdWjvEWSat7eVpHEnFYpGVA+O+LRtY0fvjg=
Received: by 10.91.26.31 with SMTP id d31mr836745agj.44.1259292109356;
        Thu, 26 Nov 2009 19:21:49 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm633161yxf.23.2009.11.26.19.21.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 19:21:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B0B1ACD.6000008@lsrfire.ath.cx>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133856>

On Tue, Nov 24, 2009 at 12:29:17AM +0100, Ren=C3=A9 Scharfe wrote:
> Use a case statement instead of calling grep to find out if the edito=
r's
> name contains the string "vim".  Remove the check for emacs, as this
> branch did the same as the default one anyway.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> This removes all grep calls from this script.


Very nice.
Thanks,

--=20
		David
