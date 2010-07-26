From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: git pull (Re: need advice on usage patterns)
Date: Mon, 26 Jul 2010 20:07:19 +0930
Message-ID: <AANLkTimP8oQ-482QMuTjnX0zvCfadoQvq+=MkADfkTbV@mail.gmail.com>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
	<20100726033634.GA30877@burratino>
	<AANLkTikPHARaosHLwaKUqL12va4F7O3WMp1I4LIpu7Mp@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 12:37:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdL3x-0000M8-Gl
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 12:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab0GZKh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 06:37:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59816 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab0GZKhY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 06:37:24 -0400
Received: by qwh6 with SMTP id 6so4951519qwh.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=6+w3keDhml6nAB/yeBYXE4R5KanTKEA2dqfSpO9JLOw=;
        b=KDE1URYyaaMsxuYI8sFFTtXLmPhI7GVal9O79BiwCFdA542u/USLbDbqt6nXrrsruo
         W4l5xL0VwE5D+Yi24koHgGUgZFos/8ffKI8j2ZTiYItkZkbcz6UyzD+qUKci7stxYUxG
         W/oIiBc6JBeSywuirEb/Je0gagHw9TLVB0n7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=UuyiZrJSbJu+xHXSMPjQd6TUwlZmk7WGTNFKL/PyakO9Z/0HPA//YdqpwpG0WT0IHa
         Puw8Dxl3xa1mlunG9C39EuOxp4l1s2cptDhvMsJcqSn2uD3ASH0UhQGag7E4YvKsdTW8
         Hnpbw3BLq8XpZkhU/8v8H0VBhieL81BnhWO3A=
Received: by 10.224.104.220 with SMTP id q28mr5917071qao.371.1280140640107; 
	Mon, 26 Jul 2010 03:37:20 -0700 (PDT)
Received: by 10.229.227.12 with HTTP; Mon, 26 Jul 2010 03:37:19 -0700 (PDT)
In-Reply-To: <AANLkTikPHARaosHLwaKUqL12va4F7O3WMp1I4LIpu7Mp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151829>

On Mon, Jul 26, 2010 at 7:56 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jul 26, 2010 at 03:36, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>> -'git pull' <options> <repository> <refspec>...
>> +'git pull' <options> <repository> <branch>...
>
> Wasn't it "refspec" because git-pull can take args like
> "refs/remotes/origin/*:refs/heads/*", not just branch names?
>

Yes.

Thinking about the pull as 2 operations "fetch+merge" should have
alerted me to the
possibility that it could update 2 branches, ... the one in the
<refspec> as well
as the current branch ... if they are different.

Thanks,

Geoff
