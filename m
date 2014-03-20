From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/8] ls_colors.c: enable coloring on u+x files
Date: Thu, 20 Mar 2014 19:14:13 +0700
Message-ID: <CACsJy8DP3buUjT95LwG+Kd70KL67xqEubrHfu9Mqx1RNa-ER2Q@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-4-git-send-email-pclouds@gmail.com> <vpqpplhks7n.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 20 13:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQbs1-0003pA-Em
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 13:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbaCTMOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 08:14:45 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:37797 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbaCTMOn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 08:14:43 -0400
Received: by mail-qc0-f178.google.com with SMTP id i8so774420qcq.37
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=x4Qgzo5q8lKhtRs9/VeAd+GqYY/GMkdcJveSTHdQAaQ=;
        b=joPPX97iOghpe8YWjCpK6eT7pD8CGjQiaJRcc/O7dgmlmDN3Mq1tgPTD/4Z9HFW9r6
         pXMNN7/wvmwqksNXweJplBUJGVhlQ5IdDUpMVPiqt5fCfREt7x/KxXPBVMqg2/zR71Ag
         t9qRWjJiGA6UQhrrQ5G3THyisJFPtiP94xksZ++GOG5H3vhU52ZRcCkaZrwyjoqMJyjE
         nZk3SOnV73OSGlihzVkM1lEfXhtw3oxcnf5mCqeo6N7ShDYQBHQQO8EdH1rE3g+hdR25
         pfHEqWtOyabtZkCpo2OCd2Kfo5vPpH970iCl48wzpc0cC2xJVCF5Ftci2xUw/Mf92iwL
         ATJA==
X-Received: by 10.224.11.10 with SMTP id r10mr43614011qar.8.1395317683311;
 Thu, 20 Mar 2014 05:14:43 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Thu, 20 Mar 2014 05:14:13 -0700 (PDT)
In-Reply-To: <vpqpplhks7n.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244546>

On Thu, Mar 20, 2014 at 6:46 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> git-compat-util.h does not seem to carry S_IXUGO. Anyway as far as G=
it
>> is concerned, we only care one executable bit. Hard code it.
>
> Why not use S_IXUSR instead of a hardcoded value? (already used in
> path.c, so shouldn't be a problem wrt portability)

Hmm..maybe cache.h does something to that macro. Will drop this patch
and include cache.h.
--=20
Duy
