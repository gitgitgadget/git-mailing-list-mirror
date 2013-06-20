From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Thu, 20 Jun 2013 15:28:54 +0200
Message-ID: <CACuz9s3pkY+VL6ZaU7ruo-8y_Htvzp890XQbxoVs15vCQqqUgw@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr> <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
 <vpqppvjpjz3.fsf@anie.imag.fr> <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
 <CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
 <vpqy5a7mmsg.fsf@anie.imag.fr> <CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
 <vpqsj0emzdu.fsf@anie.imag.fr> <CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
 <vpqfvwel4bi.fsf@anie.imag.fr> <7vobb2ym99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upew1-0006tD-7t
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab3FTN3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:29:37 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:44890 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720Ab3FTN3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:29:35 -0400
Received: by mail-qa0-f48.google.com with SMTP id cm16so1066569qab.14
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u7ehLtu9FGeaUK2kB9COidik5wQ8z1NtOt8QReSbMkw=;
        b=nnA+XpNSbaiLm5jwAF43EAJnFMi6SJseG2+MuswnEkkouS8wdY38FiZLY2qfT5BypN
         k6UK5vY1fhBzP+ULzIRs61guFLP0EOSUUU5eNlR534sjyTLFj7JriWbkfbfRqC7NbvHc
         pa47JN+8ItL6ZR0QqiTa83R8nfr/cedV5kHKWk8UF3Rk/ZKg1butyP+RfbfQQZMRAky0
         RcQ4EsovrMljBeLAhi+yNJo/yXq6IqQk5g7fuAnUE1YZRtlducYhAKWDbLFRXj/WUsCQ
         Hoag4cZUnJSE6NvreWSnVlIx5E8dsKPiasc7uUBxuVK8t3yYxBvzc9ji0oGufp9uvuZl
         UC1g==
X-Received: by 10.49.131.36 with SMTP id oj4mr9483031qeb.51.1371734974667;
 Thu, 20 Jun 2013 06:29:34 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Thu, 20 Jun 2013 06:28:54 -0700 (PDT)
In-Reply-To: <7vobb2ym99.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228501>

@Matthieu
 Ok, I'm replacing with "Reset only files which actually changed (not
those with only stat information change)"

@Junio
 I'm not sure what you're asking, sorry, I'm not able to understand
your question.
