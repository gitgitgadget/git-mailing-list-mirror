From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:20:59 +0200
Message-ID: <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com>
References: <4BFE750B.5030007@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 16:21:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdxf-0003W0-47
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669Ab0E0OVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 10:21:22 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:58635 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646Ab0E0OVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 10:21:21 -0400
Received: by qyk13 with SMTP id 13so46880qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nmuxgrZ4wDT5TWorsSe6DsNKedwzI9nfK9uGWS9Ztmc=;
        b=AH0K8KspUoXGFiqjAG1xPac/Emdx09vmceF/bcizOBZ3DvlSc7AEQBNXt5iMiqOB45
         I+sqLUn7f1quTF53HO7LexDZPLpxp9A3vHLoFq+uAf49YIf24/0lim54SiMGMMf1tE8I
         M9Eh+56hMtE1tbTSB3wJKJtQ4WKZ6iazyGrDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lvmJT/juWfPgurEwbtfb43RjkVCsJ2hiBFRxhumRoL5Cix+FzJW2S9O/o0rcqkrRmS
         aMwYNVVtnmjBlwdak88TyyEwxA21ToSnFLPjCGVYuxmsoYLdBZvYVjjuXtXZWDng7Mf9
         ynOlwNRy+VNpTAngHn3B3TNr9HH0yft3rNqdo=
Received: by 10.224.53.155 with SMTP id m27mr5907319qag.181.1274970079294; 
	Thu, 27 May 2010 07:21:19 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Thu, 27 May 2010 07:20:59 -0700 (PDT)
In-Reply-To: <4BFE750B.5030007@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147863>

Hi,

> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git pull
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: cannot exec 'git-pull': Permission =
denied

git-pull is simply a shell script (see git-pull.sh in git.git) which
executes `git fetch` and `git merge-base` among other things. Maybe
your git-pull file doesn't have execute permissions?

-- Ram
