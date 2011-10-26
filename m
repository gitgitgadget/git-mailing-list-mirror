From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: FYI: status of svn-fe speed
Date: Thu, 27 Oct 2011 00:18:13 +0800
Message-ID: <CALUzUxqc2hO-yGte-1EtX1P044moYZPfkCpsKRVBAA7J2Vtn5g@mail.gmail.com>
References: <CAFfmPPNK+D=g5h7bdYmON++HE5jF_opYxKLobqjOosj--8+9FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 18:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ6BI-0003cj-9K
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 18:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580Ab1JZQSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 12:18:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933576Ab1JZQSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 12:18:15 -0400
Received: by faan17 with SMTP id n17so1704031faa.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sVSuiNvmQ1nAI7HKCrlDPDcE/vENzj160asuQ8Jq1zQ=;
        b=gp10HVzZJzYFne8xqZRIgr/HbFMoP7znVZWzeUwUe2yFOQ50zmRstKncruf08+5K63
         HEP87Lg3Sby1SCnLgOx2Shqo6En9wTPQX39lpVBXTHnFNdkNVrPGfvz93PfwDAf+fJ6t
         1YmnkwXKln1+/HHV8F8gpVN/j6RH3idhZJq30=
Received: by 10.223.76.201 with SMTP id d9mr59920938fak.12.1319645893863; Wed,
 26 Oct 2011 09:18:13 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Wed, 26 Oct 2011 09:18:13 -0700 (PDT)
In-Reply-To: <CAFfmPPNK+D=g5h7bdYmON++HE5jF_opYxKLobqjOosj--8+9FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184265>

On Wed, Oct 26, 2011 at 11:18 PM, David Michael Barr
<davidbarr@google.com> wrote:
> I talked a lot about low-level speed optimisation after the high-level
> optimisation is finished this week. I merged my svn-fe-pu branch with
> jch/next and tested with a 1000 rev dump of patches from git-core.
> When not blocked, svn-fe can process such revs at ~5000 rev/s on my

I had to rub my eyes when I read this - what???

Good job, then!

-- 
Cheers,
Ray Chuan
