From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: finding deleted file names
Date: Sun, 6 Jul 2008 14:24:48 +0930
Message-ID: <93c3eada0807052154j9de9074s8c5625fb7507b96e@mail.gmail.com>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
	 <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
	 <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
	 <20080703104233.GA26162@sigill.intra.peff.net>
	 <93c3eada0807032345r2ff59d69kca42bc9ea7782f31@mail.gmail.com>
	 <7v1w2aw2lt.fsf@gitster.siamese.dyndns.org>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Mikael Magnusson" <mikachu@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 06:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFMHs-0006je-1J
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 06:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbYGFEyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 00:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYGFEyu
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 00:54:50 -0400
Received: from ag-out-0708.google.com ([72.14.246.245]:7084 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbYGFEyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 00:54:49 -0400
Received: by ag-out-0708.google.com with SMTP id 31so10949925agc.10
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 21:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1JU7+233OlWw4aZif6qhYT+cjTjf3gaSKVRFGXkv9Zo=;
        b=FGtiCtdtDhGQ/0vilyogd7v9dO1+OD9M83CN3eNtDcPeEjPLWiWTSVoMdM1Zqy17oW
         3abbQ/TNSC8iVHJjQsWSxSEZUqeHmq10JR/ncdi2KMd2zFCvWio3xAG/uE2vyP43HmPW
         +ZwzU9iNG2LHLmdskFLTNYEd5BG07Yr1n/9Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=vPY4ug0MXZTUce4sIxlci4U1o+8QLWYaKjYuHicsbYYYgSXAZx3gXshpvJLdvO+hEz
         Ur4yWmR7J7Ax81tjDzUI0Cd8CSu53r0/QDzfKpLDNJJOTtO1I5a953s8u+CCvC0wsXxn
         7iZwhqbs81cTXD/5hK9/VNaGdizrEx57CCoGw=
Received: by 10.100.240.17 with SMTP id n17mr1984478anh.49.1215320088536;
        Sat, 05 Jul 2008 21:54:48 -0700 (PDT)
Received: by 10.100.232.5 with HTTP; Sat, 5 Jul 2008 21:54:48 -0700 (PDT)
In-Reply-To: <7v1w2aw2lt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87496>

On 7/4/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
>
>  > ... I've made a bunch of changes to a repository, a few weeks later I
>
> > figure I've deleted a file I need but am not really sure of its name. So
>  > I want to list the files that I've deleted during the past few weeks.
>
>
> $ git log --pretty=oneline --diff-filter=D --name-only -M --since=90.days

This is good, but on my version 1.5.5.1, is giving the commit-ids +
comments as well
as the names.

e.g.,
      58d331dc02da635a60be5911dd98510f350718ad deleted:    999
modified:     frepas.tex
      LEAFLETS/999
      1b7e44fb572297bd5a6f240864dcec292fa158b0 after caption added
      LEAFLETS/xxx.tex

Cheers,
Geoff



>
>


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
