From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: sub module branches
Date: Mon, 8 Mar 2010 19:47:13 -0500
Message-ID: <32541b131003081647j2eadb8dfs758611fd4007deea@mail.gmail.com>
References: <b42431c81003080314j694114b5o433988470f13328a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:36:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoySx-0001Do-UP
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab0CIArg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 19:47:36 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45117 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213Ab0CIArd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 19:47:33 -0500
Received: by gyh3 with SMTP id 3so1128341gyh.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 16:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EhA2EYnX9AUyPK3F9h3yc81L3i/SPawx2U+IxXmlPf0=;
        b=qkRwceuZAsO+EfOiKF51u7aFYuf1QbRxHH3J7G3ZuLY4ZlSgA5CB58cLQkv0IXfVVX
         5aNIQvk1EppDrkN292SzIJnZVdLWj3WRfm57B9iIhx2yxH/VEQflbE59T8JKTcI0zS7I
         iB3+ZgPesWKPxi3yhrHqRHsVw+CMOf0IQD+w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MdNkw6JCmSYJ8JI2Fb3HAR7eyvMbrbliA8a0+C5ghpVGsjqPU77NTVo/dOaEqaG1QO
         fJ6dSJlhfzg8jivfg2U34gF0yA/DyLoZKbKqDRJlAMHml8FcDZWyVvfkJUaqKiLlr63n
         93m6dj5CTVQcsOJs10hAlIgLay3ChD5ucsDNQ=
Received: by 10.150.47.37 with SMTP id u37mr95743ybu.312.1268095653119; Mon, 
	08 Mar 2010 16:47:33 -0800 (PST)
In-Reply-To: <b42431c81003080314j694114b5o433988470f13328a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141819>

On Mon, Mar 8, 2010 at 6:14 AM, Mahesh Vaidya <forvaidya@gmail.com> wro=
te:
> I have a situation like
>
> project/source.git
> =A0 =A0 =A0 =A0 =A0 /submod_1
> =A0 =A0 =A0 =A0 =A0 /submod_2
>
> I need to modify code in all 3 repos viz. source, submod_1 & submod_2=
=2E
>
> If I create branch in source, will it propogate to remaining
> submodules ? or in other words can I have "global branch" and "global
> tag"

You could use git-subtree instead: http://github.com/apenwarr/git-subtr=
ee

That will allow you to branch all the repos at once.  It slightly
increases the effort required to extract the changes and submit them
upstream again, though.

Have fun,

Avery
