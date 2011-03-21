From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: [PATCH 2/2] update $GIT_INDEX_FILE when there are racily clean entries
Date: Mon, 21 Mar 2011 22:23:00 +0100
Message-ID: <AANLkTiniZraECRKekxWf6K-mBXfEuGkV6Cwpp4L5pVtm@mail.gmail.com>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
	<7vipvcs9xt.fsf@alter.siamese.dyndns.org>
	<7voc54qtmf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Mar 21 22:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1mZA-0006JI-3c
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 22:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab1CUVXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 17:23:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56431 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab1CUVXB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 17:23:01 -0400
Received: by bwz15 with SMTP id 15so5377444bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type;
        bh=a2AkTFXyUmraL2y+cF6o7iHlLuwFLc+qc0Jzp0DWdzk=;
        b=I+xF+fG4wPd+jLygAh6xEdutbUWycOBx4rOww/mNQVQ/oQWXoeE4NLQAY2VDHpbhHn
         l0HFGacO7LKqBlkBEl/gy9rg6EtOwP29cFThuo9VQ5k9NGi7dfXzGxVRan/rtmYXXLl5
         kf/p9CTDn3Vl9fTtVQscCqFRB8/QNAUM6vqZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        b=h0+4hTUizTntjGpO3t6HmryN3MrVcg/DMdWCRuBfAEwfqbBGidkfDiXVTQ4qqAKLfl
         Z9C/lJIPCKNkI/PILAad0tM8/0XK5ffNGq0vZzguzg37i8+H2aMAp7chH8TVUnrr19MF
         tstFUU5S77xSHXGvQzcfMzfFQJAI3CKy05/Lk=
Received: by 10.204.154.74 with SMTP id n10mr4132613bkw.33.1300742580247; Mon,
 21 Mar 2011 14:23:00 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Mon, 21 Mar 2011 14:23:00 -0700 (PDT)
In-Reply-To: <7voc54qtmf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169672>

Works for me.

Thanks.
--
/Lasse
