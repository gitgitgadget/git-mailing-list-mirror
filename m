From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Encoding problem on OSX?
Date: Mon, 9 Aug 2010 18:46:21 -0500
Message-ID: <20100809234620.GA6418@burratino>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com>
 <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
X-From: git-owner@vger.kernel.org Tue Aug 10 01:48:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oic4X-0004Oo-79
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 01:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310Ab0HIXr4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 19:47:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57037 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab0HIXrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 19:47:55 -0400
Received: by vws3 with SMTP id 3so7168347vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kezPPQhx34eFnNZuzwQQvhtQEtPy3B2fURbnKb0LFqo=;
        b=Apr1X7+8bNfFwf6KAczPLiWNXWOlN7D/hhiwCDxTR+1PXra79ZPtVpwj9f9yib+V7U
         O8n9jRP1hZUxnVEH69djQDaVUJqbit8pl3hMBnFRRcKlbmFe6bN0Kb73huOeFoo96F1k
         /w1Wccg5Z/BSAauvNvR7OByc7cFRjTyzVRjsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WbW+oWZvrK7NhD3eONry50FoUhSMCf9Q3AlE3Ib72KRr9fqbQypTzTydX44vORr4He
         nbCygTvFjJNQmRerqDBBZZ6PxAIOawEyvu0fAijWpXDfYLEmvxxjkyxLGx3N0OhVxc8o
         qXffo4yWbYdH9yCmq4tJpSwO8RIMkaRM/HxZE=
Received: by 10.220.85.196 with SMTP id p4mr843998vcl.271.1281397675090;
        Mon, 09 Aug 2010 16:47:55 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id r15sm2925650vbp.0.2010.08.09.16.47.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 16:47:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153056>

=C4=B0smail D=C3=B6nmez wrote:

> git shortlog HEAD >log &&
> fuzz log >log.predictable &&
> test_cmp expect.template log.predictable
>=20
> --- expect.template 2010-08-09 13:45:46.000000000 +0000
> +++ log.predictable 2010-08-09 13:45:46.000000000 +0000
> @@ -1,8 +1,8 @@
> =C2=A0A U Thor (5):
> =C2=A0=C2=A0 =C2=A0 =C2=A0 SUBJECT
> =C2=A0=C2=A0 =C2=A0 =C2=A0 SUBJECT
> - =C2=A0 =C2=A0 =C2=A0SUBJECT
> - =C2=A0 =C2=A0 =C2=A0SUBJECT
> + =C2=A0 =C2=A0 =C2=A0SUBJECT=F0=9D=84=9Es =F0=9D=84=9Es a very, very=
 long f=F0=9D=84=9Erst l=F0=9D=84=9Ene for the comm=F0=9D=84=9Et
> message to see =F0=9D=84=9Ef =F0=9D=84=9Et =F0=9D=84=9Es wrapped corr=
ectly
> + =C2=A0 =C2=A0 =C2=A0SUBJECT????s ????s a very, very long f????rst l=
????ne for the
> comm????t message to see ????f ????t ????s wrapped correctly
> =C2=A0=C2=A0 =C2=A0 =C2=A0 SUBJECT

Very interesting; thanks for a report.

=46rom the definition of fuzz(), it looks like

	sed "
			s/$_x40/OBJECT_NAME/g
			s/$_x05/OBJID/g
			s/^ \{6\}[CTa].*/      SUBJECT/g
			s/^ \{8\}[^ ].*/        CONTINUATION/g
		" <log >log.fuzzy

failed to completely match the fourth and five lines of the shortlog:

	A U Thor (5):
	      Test
	      This is a very, very long first[etc]
	      Th=F0=9D=84=9Es =F0=9D=84=9Es a very, very long f=F0=9D=84=9Erst=
[etc]
	      Th<malformed treble clef>s <malformed treble clef>s a...

Could you confirm this?  What does

	locale
	printf 'Th\360\235\204\236s\n' | sed 's/.*//g'

print?

Jonathan
