From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 04/11] for-each-ref: add '--points-at' option
Date: Sun, 5 Jul 2015 21:31:17 +0530
Message-ID: <CAOLa=ZRopRLZ8MOw6tuN9WUY3gyPNvoTn1oP=smh2-cKOMtQcQ@mail.gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com> <1435850470-5175-4-git-send-email-karthik.188@gmail.com>
 <vpqegkq8p88.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jul 05 18:01:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBmMb-0001hg-Oc
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 18:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbbGEQBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 12:01:48 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34471 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbGEQBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 12:01:47 -0400
Received: by obbkm3 with SMTP id km3so93196537obb.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AFo8d0gAD807BFWnIc+xePoHMiQJ53yMMGSZ7WaTbmc=;
        b=Q2NocrkE08RbkWudnRDC7g3gTTqqXDKlRbcBjOz1SXLJ6zC7AlmlKUZUTFFXOk17pE
         ongX7DEboanqKLZVcRKlf5xHAyHtxzZwYC7pN1siEFwcDRoUl2dAqQOAUZQR2zYPGFt6
         zWXhlOkhzLn7ilW3GGasd+P+BwZu7GI0XzEUo/Mj0va49NnG0ZfkXiX2xOMgSQPJSegy
         SvXUAXbqP6ivib3UfAldjr8xXiKpSMU0SuWZhggIOdgWzC92Gx7Hn6NecoCqSIviwaYK
         HwL8HGh8Xy5J98uOFjBNWIgZG5CSeDCBIXMRVjoSu4/lOozLdziQ//WPfg8oik6Foayy
         9rPw==
X-Received: by 10.182.33.38 with SMTP id o6mr12547202obi.41.1436112106864;
 Sun, 05 Jul 2015 09:01:46 -0700 (PDT)
Received: by 10.182.95.174 with HTTP; Sun, 5 Jul 2015 09:01:17 -0700 (PDT)
In-Reply-To: <vpqegkq8p88.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273368>

On Thu, Jul 2, 2015 at 10:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add the '--points-at' option provided by 'ref-filter'. The
>> option lets the user to list only refs which pertain to the
>> given object.
>
> You are using "pertain to" (here, in git-for-each-ref.txt and in the
> docstring), while the common use it to talk about "point to" or "point
> at". I find "point" clearer.
>

Alright, will change that. Thanks :)


-- 
Regards,
Karthik Nayak
