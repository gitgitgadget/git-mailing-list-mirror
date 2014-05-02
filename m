From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 14:05:23 -0500
Message-ID: <5363ec734572a_70ef0f30cdc@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <87k3a4xjzg.fsf@fencepost.gnu.org>
 <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 02 21:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgIwM-0007sz-1t
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbaEBTQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:16:04 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57828 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbaEBTQC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:16:02 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so5741020obc.3
        for <git@vger.kernel.org>; Fri, 02 May 2014 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=9RmvgA6m/gdgJoN1TdOmOA8+n3gUbqzOaneGUiyxulk=;
        b=c15q0mIxLHjzYhYtYtWH6jmrNrfezeGCc2J6YO2BKM13eyqMYA6MdyL9lvCqkI/32C
         s8xaHTF1sKShjA3tjURBtjifRY7A6RWKflu4gaqBP4v10DNCT2WXimsrnqE9ln6sKKhp
         0gnqNVwk3bB/wz6TQF9cURXmBjVnGXPsodjNgrsgZszyb+Us/iXCtrndPGbFJ5qUOEip
         JjoaUtpjf7D0ysefnfmmmuhEntDNrd/iIUHhDBSW6/q+/nCSZZ8yeIS0M2n3ZuKOoAej
         VQD6cYbKHk5H3gj1w10rTh2JSDtFnHUGmbBfwOP6Ro9JWN5o1cfKajVgorhtCqmbATNi
         QNHQ==
X-Received: by 10.60.77.35 with SMTP id p3mr18539620oew.46.1399058161711;
        Fri, 02 May 2014 12:16:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm48644542oeb.3.2014.05.02.12.15.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 12:16:00 -0700 (PDT)
In-Reply-To: <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247955>

Philip Oakley wrote:
> From: "David Kastrup" <dak@gnu.org>
> > Marc Branchaud <marcnarc@xiplink.com> writes:
> >
> >> To that end, I suggest that pull's default behaviour should be to do
> >> *nothing*.  It should just print out a message to the effect that it
> >> hasn't been configured, and that the user should run "git help pull"
> >> for guidance.
> >
> > Fetching is uncontentious, and I _think_ that fast-forwards are pretty
> > uncontentious as well.
> 
> While the fast forward is /pretty/ uncontentious, it still maybe 
> contentious for some.

So? No defaults can please absolutely everyone, the best anybody can do
is try to please the majority of people, and merging fast-forwards only
does that.

-- 
Felipe Contreras
