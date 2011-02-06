From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Sun, 6 Feb 2011 11:42:54 +0700
Message-ID: <AANLkTinHicAkOmOnXOX4h5N-44C55bGnFmutXZBcssWP@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <m3zkqe8xc8.fsf_-_@localhost.localdomain> <201102051931.10979.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Sun Feb 06 05:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlwTP-0003iU-B3
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 05:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab1BFEng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 23:43:36 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53435 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1BFEn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 23:43:26 -0500
Received: by wwa36 with SMTP id 36so3734228wwa.1
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 20:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=baUah+P1gK2PYZpYIC3sT/3+7Nt0k67CYWJJxAvo6A8=;
        b=EOhF4uTApitKtSAyTUT4yxiGb9a6AgB+Fr5rz4I10hr9HMN5WQvJRCMo0zR1+wC5Iq
         0cv17EVDeGZde7rx42rM6qArMczjb5CBIwGIrD2hU6oSNM64kABn9wrcQCqw46Bnm20P
         Bb1IUlAmU1Xevr/sW5z5OEgDQRU6k/vvzwcn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TVStVRiQs4f3hOpnqNrVnh44RNfqhH3/jWN6cszySKwPUYKdcgvhJQSMRUQOAAtuXw
         IZgtCPZclOGiS47tOisI316k/12s8qVY2Q98uRM4AOwPHhA83+FSMDD4AufBZ4DoBnvK
         tH9LLrT88hboed44yMZY19b+lh5AnAOkZTvDA=
Received: by 10.216.87.130 with SMTP id y2mr12724460wee.58.1296967404930; Sat,
 05 Feb 2011 20:43:24 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sat, 5 Feb 2011 20:42:54 -0800 (PST)
In-Reply-To: <201102051931.10979.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166140>

On Sun, Feb 6, 2011 at 1:31 AM, Thomas Koch <thomas@koch.ro> wrote:
> Jakub Narebski:
>> there is (supposedly) problem when checking out such tree (see email
>> referenced above) with an old git.
> Proposal:
>

(Elaborate the "handle" part from your first item)

- Teach diff machinery about empty trees. At least diff-tree should
show empty tree addition/removal. diff-index and diff-files can learn
later when index supports empty trees.

- Teach merge empty trees.

> - Implement the possibility to checkout/read/handle empty directories as soon
> as possible, even in the next 1.7.x release.
> - Don't implement the possibility to create/commit empty directories yet.
> - Implement the possibility to checkin empty directories next year, but allow
> it only, if the user knows that this breaks backwards compatibility of the
> repo. (Generate warning and require --commit-empty-directories option)
-- 
Duy
