From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 16:05:36 +0100
Message-ID: <AANLkTinNNBupCi09_W60qdDGFc5CN-p=rKaf_FKW0kj1@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<ih95fg$62b$1@dough.gmane.org>
	<201101201403.39174.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 20 16:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfw54-0000be-7x
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 16:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835Ab1ATPFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 10:05:40 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38141 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab1ATPFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 10:05:38 -0500
Received: by qwa26 with SMTP id 26so714904qwa.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 07:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JidpLKCPgllc71Y5bivTBS4MkShiOj59l9u6fXQBiXw=;
        b=FnTEuujBPs6e9dQuwc+EbHEpE1XXbsNzmBcaqBneVkImd/xAcaMoicWBzfFLUkkjr0
         YF6CPVwB2emkn/IDFCafs+wtmQTBeIfmCVTTOv5GZXoBxFC6sDjTgB9vEHavrHZsOcqy
         cpyP9qvoBhkDoz5EMhAsKK7sUdJPKs+BO0LZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tevrS2C8MORnoiO5LXya6bIAzZq+RO29bxNZYbRjrsy7ZxEbD63NQU+hzKOD3NzFiM
         u76wKieRmwW8WjVmcjeXD8i3LzbN2aB2wD3x2tSvk0paWQQD4NQfr1JCZgX73RcZ/O3m
         qVpld5fDCkXP5APz3SN3BLyHpjMkKDp4nt4lE=
Received: by 10.229.218.197 with SMTP id hr5mr1926587qcb.14.1295535936417;
 Thu, 20 Jan 2011 07:05:36 -0800 (PST)
Received: by 10.229.80.84 with HTTP; Thu, 20 Jan 2011 07:05:36 -0800 (PST)
In-Reply-To: <201101201403.39174.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165315>

Ok so there was some movement with the result that no one uses what was set up.

Presumably because git developers don't want a bug tracker.

So how can I ensure that this particular issue doesn't get lost? Is
there no way except hope that people get involved in fixing it
straight away, and fix it straight away before they forget about it?

We worked around this on the KDE side by forbidding pushing any ref
with the name HEAD to the remote, but it's still a git bug.

On 1/20/11, Thomas Rast <trast@student.ethz.ch> wrote:
> Stephen Kelly wrote:
>> Why does git not have a bug tracker?
>
> http://thread.gmane.org/gmane.comp.version-control.git/136500
>
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
