From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the object store
Date: Sun, 5 Sep 2010 11:20:35 -0500
Message-ID: <AANLkTinUnpANbwZZtQyp9daijMebKcBFytHPzP24nA=o@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
 <20100905060854.GA15511@kytes> <AANLkTimqMJ1vHaJL65RZ4PuxONtg1evn4vBdPks_odqq@mail.gmail.com>
 <20100905084731.GB15511@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 18:21:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsHxl-0003zj-TJ
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 18:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab0IEQU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 12:20:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35846 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab0IEQUz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 12:20:55 -0400
Received: by gwj17 with SMTP id 17so1320289gwj.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=fJb2REEFTMoV+7gURfAGdMXcEPJutDiMPCBMkN0P974=;
        b=h3bTf1VbTXu390LKgWuE9RWmPvXf5hQcf8NvveMI1UwI4Jb/VXDbLBbKhuhRXquQW8
         jDoh0YGeWnY104xseGFJvavmF5qbFpy+sxQiq+yPLkx6twTuGGV+o8LF0HWPYsFdqJXG
         FLcCTfRlEhKEUSwVTzt2gZ0Fp9DDLMUaGBjBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WxQsKftaxZIzz7dxfPCesXhrN+5PH1hxxU01us2FwtvlRSXf2XvX0HxSIZ1Xv7lKP9
         TaRlcwwCnfnMs+bS1wdCVW5bbr7CbPhFeBvy+g/Zw5riyk9wqRvpOcQe22IrvqO4t33a
         jxrGAwTSEl5xFmq0ixrz6FZVK3HDmstITTYKE=
Received: by 10.150.185.4 with SMTP id i4mr1677390ybf.302.1283703655098; Sun,
 05 Sep 2010 09:20:55 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sun, 5 Sep 2010 09:20:35 -0700 (PDT)
In-Reply-To: <20100905084731.GB15511@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155459>

Heya,

On Sun, Sep 5, 2010 at 03:47, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Sverre Rabbelier writes:
>> I don't agree, imagine implementing hg-remote-svn (or the conceptual
>> equivalent at least), it would require the same functionality, yes?
>> You need to retrieve something from fast-import that you previously
>> gave it.
>
> Ah, yes. I didn't think of that. If fast-import is already mature,
> it's probably a good idea to design a new protocol altogether based on
> this and not call it fast-import?

That's not what I meant at all. We should still use fast-import, we
should just design this extension to the fast-import protocol in such
a way that it would also be useful when implementing something like
hg-remote-svn ;).

-- 
Cheers,

Sverre Rabbelier
