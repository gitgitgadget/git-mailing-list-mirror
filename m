From: Fyn Fynn <fynfynn@gmail.com>
Subject: Re: Default color for commit hash in git-log is unreadable on bright 
	background, and can't be changed.
Date: Tue, 24 Mar 2009 15:07:44 -0700
Message-ID: <1a04eebf0903241507i46d8eda0o1b75702073a88c96@mail.gmail.com>
References: <1a04eebf0903241416g67e7abfdh6b3aa746f12b0e83@mail.gmail.com>
	 <7vmybavbg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmEoB-00015m-Cj
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbZCXWHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbZCXWHs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:07:48 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55847 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbZCXWHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:07:47 -0400
Received: by fxm2 with SMTP id 2so2497096fxm.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i0iSbaRk/a56k04jLUGm8oX18zzrj5ebpTSI/h3DTU4=;
        b=RW9z2GKWYtgBzAXzO8Y/p57SgrJbfAt6n7k7TzXcO5Xy67kkI4edTdHMxWJHbItL3P
         lrTX0JvW1Oel7o4Y2hvsFxk/F1jeHytJwoEkeX/hTntldye6dYxUfPKstOdaBbcxjPS/
         CCl4LxlMrP+1Xqm33nG65o6ZKgleGU/Fa8HfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cVNimOfsnvWAbyF2nR/Rhv+UWop6a76fzvvmMuYhQz9JqWD0UGws591Iq3L7Ww3AxN
         aHxxgo0h01p/LHVD18PWC/pKf4NPMtqQOa44u/nifD+m+dQIvX/YpHngrUZ7+U6lXY1J
         93aVWOaNnqdqfSS2GVEDc+YLRG04MAg69eKno=
Received: by 10.223.119.5 with SMTP id x5mr7551516faq.40.1237932464922; Tue, 
	24 Mar 2009 15:07:44 -0700 (PDT)
In-Reply-To: <7vmybavbg9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114498>

Thanks a lot, Junio. That's exactly what I needed.

Seeing that you can customize the color so easily, this whole thing is
a non-issue.

Cheers and thanks for making git awesome,

Fynn

On Tue, Mar 24, 2009 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Fyn Fynn <fynfynn@gmail.com> writes:
>
>> Unfortunately, the default text foreground color for the "commit
>> <HASH>" line of git-log is 3 - yellow.
>> ...
>> Is there any good solution for this that I missed?
>
> Perhaps...
>
> $ git config color.diff.commmit cyan
>
>
>
>
