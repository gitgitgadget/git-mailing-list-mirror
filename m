From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 03:02:39 +0530
Message-ID: <CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
 <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com> <CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 23:33:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhnzo-00052f-4k
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 23:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935189Ab3E2VdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 17:33:21 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:62656 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab3E2VdT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 17:33:19 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so5767627iea.31
        for <git@vger.kernel.org>; Wed, 29 May 2013 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q8za+kAtwav4JoX+/f83LaW/k9ySGJIxt1zz4U7SQ/Y=;
        b=ETO8pS15JGQjW8UN2j/KuzgVqqxjcJuVCIOHFM/mnoL3Ypmr7DEcS3GWAMoA2wggrj
         Y+mqLt68hc1quOXw+toX/t06aP2Yb/L2eYifvFIbsJkzvGz/IXMmYaFsqLmwHQh1vA/L
         RMBuCoPCURy2LeKN3PFBAd6wFiLtJej/63vc+L1GjmvN9RAtjjYBcWZDlxT0LFPWWOPw
         9Qte8UhEQPA5DyczDCQ1OncxH0xThjZwySnAMTRJuodrhf9D6ERczLSZrQI4xAehPaOE
         lHfQvBYCuoSBOM/qIXv9U1eVjsnG5UPu3xEipnCKYgC/qMe7HURpLmPSo6NFpMumao8/
         bMPQ==
X-Received: by 10.50.171.161 with SMTP id av1mr2263629igc.104.1369863199299;
 Wed, 29 May 2013 14:33:19 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 14:32:39 -0700 (PDT)
In-Reply-To: <CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225893>

Br=C3=A1ulio Bhavamitra wrote:
> Agree, these aliased should work as a fallback or as an automatic sho=
rt
> version

Making builtins override'able is also a terrible idea.  It opens doors
to potential bugs we don't want to deal with.  Simple example:

   am =3D log -1
   log =3D am -3
