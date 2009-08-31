From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Mon, 31 Aug 2009 05:29:50 -0700
Message-ID: <fabb9a1e0908310529q4c601a73t671cc2813dfdb1a3@mail.gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 14:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi61z-0002WM-Bq
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 14:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbZHaMaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 08:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbZHaMaK
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 08:30:10 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:57876 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbZHaMaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 08:30:09 -0400
Received: by ewy2 with SMTP id 2so253396ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3Hnk8HHhB7y4TDuSiNYRH5AmndGJ7v1NXX1O2EUFu1E=;
        b=wyNbPmkzZO2+2OEAnfwFsyeTZ373fV8I9FA8lulA+RU9L7JwFYNyzk9Rtxe8zKLcjf
         vOXaHOcqUZW0eW6JEGau8BQjBWtuFV7EqtDflgHHEsBhkg2tZG/KBbOhPvKbv/TTDj4T
         IfMrW1dR4hd7+62/E9mX6H+cjAC5vgE8oCLe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nyH09MpChWX6vbKxJjxwswgafyC0D0CntO9YAeC8x3dhbTqaY8A7mAlectDgH/bmat
         V848ZALjNHo0vHziKV9D+Jmbu/ZLBnzhhLJ+4DclYc25PmJNEVHmoDBvrijKRhzYNkFO
         NgV7yadktRhX3grRj6piKgocuEv4FH43LWfS4=
Received: by 10.216.1.85 with SMTP id 63mr1105745wec.26.1251721810114; Mon, 31 
	Aug 2009 05:30:10 -0700 (PDT)
In-Reply-To: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127480>

Heya,

On Mon, Aug 31, 2009 at 04:21, Michael Wookey<michaelwookey@gmail.com> wrote:
> Provide a dummy variable to keep the compiler happy.

Should we not instead check the value?

-- 
Cheers,

Sverre Rabbelier
