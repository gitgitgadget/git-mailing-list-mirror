From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Tue, 4 Mar 2014 09:08:31 +0700
Message-ID: <CACsJy8Ct41PRb=_Ez7FLXbdiZkTU-tFYqtAxow9mCw7wYAfOhg@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-4-git-send-email-pclouds@gmail.com>
 <CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:09:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKen8-0000yw-49
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 03:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbaCDCJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 21:09:04 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:52811 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981AbaCDCJC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 21:09:02 -0500
Received: by mail-qc0-f172.google.com with SMTP id i8so4723177qcq.17
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 18:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CIfqZyZtJ0cJbrG0ByfKVgdP3hXqgmiD7sYn8ycoP7E=;
        b=mHMQyn91bXeMvFCOvAuSFUAP0Ix4hr0eC8oJX3UYRzNrT1AXXZ+XlpTpL6mNJI2HpV
         iFuc6VbXAi/5yGZbJhiRYjb11/s2tSzXdq3kZfM7tZmxj36lO2u7f2ghU1YK2KNiFQ0Y
         LohIY6Ku489Tljk8eccuqMhDvV/6J3G6Cj6ev4s1dmeFgXhVIxSnbTAO+JbM3woOmKmk
         ppODPV9h+sRe+naWvCErXAeSRe5QDPKYLHTgGfmZmvGblgZIuFY8zb1/vhUhWsKsYhsf
         GfyJ8df60ncBzaqcFOKfdEf7bwKYri0GL6g/YpnO3cCfTIrbr/cZnMuDDHmxSrt+R2hA
         liRg==
X-Received: by 10.140.84.40 with SMTP id k37mr6491187qgd.98.1393898941458;
 Mon, 03 Mar 2014 18:09:01 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 3 Mar 2014 18:08:31 -0800 (PST)
In-Reply-To: <CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243322>

On Tue, Mar 4, 2014 at 3:28 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> "git rebase -e XYZ" is basically the same as
>>
>> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
>> git rebase -i XYZ^
>>
>> In English, it prepares the todo list for you to edit only commit XY=
Z
>> to save your time. The time saving is only significant when you edit=
 a
>> lot of commits separately.
>
> Is it correct to single out only "edit" for special treatment? If
> allowing "edit" on the command-line, then shouldn't command-line
> "reword" also be supported? I, for one, often need to reword a commit
> message (or two or three); far more frequently than I need to edit a
> commit.
>
> (This is a genuine question about perceived favoritism of "edit", as
> opposed to a request to further bloat the interface.)

Heh I had the same thought yesterday. The same thing could be asked
for "git commit --fixup" to send us back to the fixed up commit so we
can do something about it. If we go along that line, then "git commit"
may be a better interface to reword older commits..
--=20
Duy
