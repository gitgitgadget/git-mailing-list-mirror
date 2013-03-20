From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: regression in multi-threaded git-pack-index
Date: Wed, 20 Mar 2013 08:17:18 +0700
Message-ID: <CACsJy8ARYEtU4_6zJQXGDyE4FunbV3Gk0BocNW3cZtV-uSVFOg@mail.gmail.com>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <87hak74cse.fsf@pctrast.inf.ethz.ch> <87620n4clo.fsf@pctrast.inf.ethz.ch> <87obef2wut.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 20 02:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI7fW-0003uv-8F
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 02:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab3CTBRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 21:17:51 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:38750 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab3CTBRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 21:17:50 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so1253320oag.32
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 18:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8Ygod9qc7IHkLRJCpAszEBwwXhjOENxpo5p5yx2Deow=;
        b=bV3jzkNRMwhI9hlLxZFBzTKp+9K/GgDJqZqwctiYOHPIuu+nBwMBQvNpSWQMzCYFXz
         naxcHSRcufqG2lw8tf5gA/7KN7ci7KFCZ5lxv8DzMrO6zM9PaBS6kII+aP2TGX0wzZpl
         oFis+uRtRNjGM2BsqOJJnd+slz7zE/fhEzcpUQdP+fr2anmDveH1Ma0RFFFYaB6kRI9U
         c0i9Y6CvSHBJw9dMz8cZ87hl6GU9N41g1oBoYLoMfTOkYTFb7Be/+hPATyua7L/MFBK0
         GEBP3DCf1JZMrSAsY3jGZ16/PFW+x4wjpFwfREmO54dTpEe7pTUzW+Y1+/PBLjWXxndb
         CGlQ==
X-Received: by 10.60.6.199 with SMTP id d7mr2841369oea.137.1363742269662; Tue,
 19 Mar 2013 18:17:49 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 18:17:18 -0700 (PDT)
In-Reply-To: <87obef2wut.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218568>

On Tue, Mar 19, 2013 at 11:11 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Actually scratch that again.  It *is* a stack overflow, except that this
> is a thread stack, for which the OS X defaults are 512kB apparently, as
> opposed to 2MB on linux.

Thanks. I was scratching my head last night wondering if there was
unprotected access to the object database and probably would have
continued this morning.
-- 
Duy
