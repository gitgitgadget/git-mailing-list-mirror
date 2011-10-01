From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sat, 1 Oct 2011 11:34:12 +1000
Message-ID: <CACsJy8Dm-vSoki9Fr7s=DH7oRYL-a=kF7q9mBwo55ZxsLg5DTA@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
 <1317427503.4331.37.camel@centaur.lab.cmartin.tk> <CAN0CFw0+v9qscJ+isQdwJOHT4Ajsk-96QK8gQFsu9E87a3j+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 03:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9oTY-0000QX-Ie
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 03:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab1JABeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 21:34:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36682 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab1JABen convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 21:34:43 -0400
Received: by bkbzt4 with SMTP id zt4so2356265bkb.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 18:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pbwer+7/RknNEndMcREj9VnMqu7KDK8RI4MMNsGhtko=;
        b=XRxvI88zNy1D/2WowWhhUFEzl68wHEYBTrUsqyLBQ5m3pk4DYT9hoWpuQF+Za7BGPY
         OaNkrzNjndRLcu1QQOtAvxoFOLnhvzsRUwi0uf4WdgIGNUKZjt3lLl/ijUX9ZhqN0s+M
         H/8tI5VqJzL77LOjSeW/V3YjGLH5/ztPN2VSA=
Received: by 10.204.4.140 with SMTP id 12mr7683161bkr.95.1317432882119; Fri,
 30 Sep 2011 18:34:42 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Fri, 30 Sep 2011 18:34:12 -0700 (PDT)
In-Reply-To: <CAN0CFw0+v9qscJ+isQdwJOHT4Ajsk-96QK8gQFsu9E87a3j+Ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182531>

On Sat, Oct 1, 2011 at 11:31 AM, Grant <emailgrant@gmail.com> wrote:
> I have a series of files containing server-side code which make up a
> website. =C2=A0The entire layout contains only a few folders, but tho=
se
> folders contain many files. =C2=A0I want to be able to allow access t=
o only
> certain files at a time, sometimes only a single file. =C2=A0Can that=
 be
> done in the way you describe?

If you can gather all sensitive files in a subdirectory, then you can
split that directory into its own repository (see git-submodule man
page) and grant limited access to that repo.
--=20
Duy
