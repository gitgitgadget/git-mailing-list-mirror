From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Sun, 7 Mar 2010 11:30:58 +0100
Message-ID: <36ca99e91003070230r1755277aq7acd916d214e3ba7@mail.gmail.com>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com>
	 <7v1vjvebem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 11:31:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoDlN-0002yT-Ma
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 11:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab0CGKbE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 05:31:04 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:54786 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0CGKbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 05:31:00 -0500
Received: by fxm19 with SMTP id 19so5474017fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 02:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=khDSRy2w+VTC1kSQhmo0Vhe1vZG53bPuN+uuaIsUzOc=;
        b=vO0+7xL2nQ4AvVzPDBLWM1lX2jdjN10s8I0l08G7XTwTz6dcGbzyJzXjqKSTvZW54W
         U89S8FtVBFNkSQoX7QJylK0H8ufKnfhIL40+VTt3dlp0cvRyuCtI3UV9HiRL3ozopRNO
         XGeunY6ChfCDnATNpe6ZrvfDC9a4dEu+0VKyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cv2jLu6wcRIe0H0O3x3AOoyvnIdg6y/RHos9/k2Mk2OkujHcgeCipj9TAXN/L3QRoJ
         qI6qVa7OP+qvDqZiN8jX7mKi5voR4vrfKJMp8SfhuobxGsh5aT0VVC4kQlqEZF1yWzoy
         foAzBbS7MvOu4BSGe4n57DZ3+n53K1WLxWM9w=
Received: by 10.223.143.18 with SMTP id s18mr3970882fau.64.1267957859310; Sun, 
	07 Mar 2010 02:30:59 -0800 (PST)
In-Reply-To: <7v1vjvebem.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141629>

On Wed, Nov 18, 2009 at 23:05, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> I used to set GREP_OPTIONS to exclude *.orig and *.rej files. But wi=
th this
>> the test t4252-am-options.sh fails because it calls grep with a .rej=
 file:
>
> Yuck. =C2=A0Will apply.

Ping.

Regards,
Bert
