From: Asger Ottar Alstrup <asger@area9.dk>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 11:33:57 +0200
Message-ID: <8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com>
	 <32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:34:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WZK-000225-Gq
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbZEYJd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 05:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbZEYJd5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:33:57 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:46337 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZEYJd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 05:33:57 -0400
Received: by ewy24 with SMTP id 24so2944906ewy.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=kEuEesEAEHyi5R6bb94iEKwYAtEtPLjSA9pJmDzsJOc=;
        b=expnQHvd5gSugEWrOatQz/lyYP22vc6zLQEmp7JfgWKoNwROjCWEon1b3/EVfWSB5Q
         f5wrGFuMalzFD2kEVlxNFHOoSskGmlJgCIResW7lr3oldDP+SZVrxsRfTr/PMr0Vw5Bo
         nsHJmTS88NEZgsmEYRUCQaVJGzz3Y7JXZJJyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Ra8HdKw/7Bt9V4wLQCEE3HU4HKd8EI9K1yiedo3cB8zmCI8FuAFf/h7oMye6VY/3c1
         QltYj2Fc42lquBD2o0qMns2foy2tr3c2zaicE0jfkACzp+qOEm6c5QfdVPXozWocwGZP
         PGxC+tSQtFIAQN/uf7icWXDHAp/mfg3mK4zCY=
Received: by 10.216.0.81 with SMTP id 59mr1546155wea.77.1243244037758; Mon, 25 
	May 2009 02:33:57 -0700 (PDT)
In-Reply-To: <32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com>
X-Google-Sender-Auth: 63303545ec7f88e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119908>

On Mon, May 25, 2009 at 9:59 AM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Mon, May 25, 2009 at 3:21 AM, Asger Ottar Alstrup <asger@area9.dk>=
 wrote:
>> Does git subtree support splitting at the file level, or only at dir=
ectory
>> level?
>
> Currently only at the directory level. =A0In theory, there's nothing
> stopping us from working with any subset of files... but it's really
> much simpler this way (both to code and to explain) so I'd much rathe=
r
> leave it as is. =A0Can you reorganize your tree so that you divide th=
e
> needed files into different subdirectories?

No, that is unfortunately not so easy. If we could, I suppose we could
use submodules instead.

Are the subtree split and merge operations effective? I.e. how do they
scale with the size of the original and reduced repositories? I.e. is
it feasible to use hooks to automate the splitting and merging
whenever there are changes in the original or reduced repositories?

Regards,
Asger
