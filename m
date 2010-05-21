From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Changing indents
Date: Fri, 21 May 2010 16:05:27 +0000
Message-ID: <AANLkTikWhkX5mJT1f-3oIeLEVwttRhUm0MbGI-0W08b_@mail.gmail.com>
References: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri May 21 18:05:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUj9-00062B-60
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361Ab0EUQFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:05:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41982 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab0EUQF2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 12:05:28 -0400
Received: by iwn6 with SMTP id 6so1327731iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CBJmmxhh5VKkbzKIf94VNXcjQ6GGtH27XDj22TVW3UU=;
        b=nD7FMs5QhwO5Lw5cCDKrhcXrjhJEl/XdkakTLOV2ZRtTdo8J7Tg9QE+OkKbD+PcnkM
         bCrM0yE2C4HZFDFgSmgKymge/yiLMwkIfqr2+6Ihy7JE17GrBqMoj5O4te8citCWxymv
         E5LCMkbb9qQEyLyCgF4TiIYA7Z0dgx6fFPEv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d3NQbWKbmaxG7g/rqPgOkAVYtDZzd75qTbC9coqQ4+OIcylvnlfx9BBY1b074wuU40
         qDz5HghEjAt4WA/aAgqz2ri5MDSExRa66mz0L/DnL5GbUQ6RwJ5ucWDzDtoTmzQVseIy
         +EHUO2Z8ytrFbHNF6Uln4E6i89IsYq+fHovlE=
Received: by 10.231.148.131 with SMTP id p3mr1679268ibv.18.1274457927926; Fri, 
	21 May 2010 09:05:27 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 09:05:27 -0700 (PDT)
In-Reply-To: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147476>

On Fri, May 21, 2010 at 16:01, Andrew Keller <andrew@kellerfarm.com> wr=
ote:
> Is it possible to change the indent of a line (or multiple lines) wit=
hout rewriting the whole line? =C2=A0Or, more specifically, can a commi=
t exist that modifies the leading whitespace of a line but still allows=
 you to trace the origin of the line to a previous commit?

Maybe you want: git blame $sha^ file ?
