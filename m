From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [1.8.0] (v2) default "git merge" without argument to "git merge @{u}"
Date: Tue, 1 Feb 2011 00:01:10 +0000
Message-ID: <AANLkTi=EX08rAucRm7uVCTLUgjOi+skoEF1rEhpHVMsi@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk3hL-000783-Kw
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab1BAACO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 19:02:14 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:65440 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab1BAACN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 19:02:13 -0500
Received: by qyj19 with SMTP id 19so4063918qyj.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 16:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=okpq+N/GEr7iHmna+rsrrzr9FweBvMDIqi/26ERnRss=;
        b=MTyGUBFu3NeSZkE8PaPakfRbrUAYFdiEhnbcakT7iekuoeITfWH0en6vblkJhCrRvW
         XKJ5ffzZkGqnYgThgekPncw9lzb+ssvlLoWPiQAoVykthYHrq2zrtfzhg+bLUxFRbvci
         nn3K3Vip+xzXPbzfnBO2avD54pUGIACQ+UWqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=B7eKWM/yD+8pSdxl4wsXBG4FsIBujELWxgD7fjSYNSJ9qEQFHciPFcIWg4i8jvJpP0
         KbpoZIEHh7UNfNNMFF3/EKPdcMdWeGe6lGHQhqJeMpA8k8ZMpPY2HumD6geqTago1iHp
         lXtMsBFett0v+p6U5IyS8scBCDp3QeLpVAqWk=
Received: by 10.229.235.4 with SMTP id ke4mr6534829qcb.63.1296518530927; Mon,
 31 Jan 2011 16:02:10 -0800 (PST)
Received: by 10.229.231.208 with HTTP; Mon, 31 Jan 2011 16:01:10 -0800 (PST)
In-Reply-To: <20110131225529.GC14419@sigill.intra.peff.net>
X-Google-Sender-Auth: EeJRWbDVvQaLIWG-Oys1Ay8STKY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165777>

On 31 January 2011 22:55, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 31, 2011 at 12:50:30PM -0800, Junio C Hamano wrote:
>
>> Perhaps I should start a new directory in todo branch (say, 1.8.0), =
accept
>> patches from people? =C2=A0I'd grudgingly admit that using Wiki on k=
=2Eorg may be
>> less burdensome (I hate editing inside the browser myself), but I'd =
want
>> to keep the mailing list the center of discussion and am afraid that
>> forcing people to go to Wiki would fragment the discussion.
>
> I really wish we had a git-backed wiki. I also hate using the browser
> for such things (though browser extensions to edit textareas in a Rea=
l
> Editor at least make it tolerable, it still ends up clunky).

You mean like ikiwiki (were it used on the main sites)?

http://ikiwiki.info

-- Thomas Adam
