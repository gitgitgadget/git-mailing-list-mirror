From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/9] add options to ref-filter
Date: Sun, 7 Jun 2015 15:10:04 +0200
Message-ID: <CAP8UFD2FCKTbfzRtNWdwimR93-k3WWoQPOWEKsSPrVpdcEmkDg@mail.gmail.com>
References: <5573520A.90603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 15:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1aLE-00067k-3K
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 15:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbbFGNKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 09:10:07 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37917 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbbFGNKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 09:10:06 -0400
Received: by wibdq8 with SMTP id dq8so58794653wib.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WqcFjOIeeXaZkt+xhOKWRuSaesCE3GcsXgrR5kakTUA=;
        b=hznGEuRtzsru6nR/mS0/0I7zA6RoHyqUGGGxkNgcgGjopI401RLoHZ6D4DEpT2gJwa
         ekFS9JAXFYYg+hH7l/MARifZsm2HMTOD1jD1dUSMvolRwf8PYlJSaouGAEoPxaPkFiaY
         18IThXXH3ZljCc9K9rbKpqbzO1QvGKTM9p49Wnicp7BZE5msLckLZ6TAt/E66sptM7eX
         hIHJykko69Rdbl1RK4hScurrilh4odCBAjxIvB/LztJVwvAxN5GwQN1xlmd5t3VMIhk0
         bCxOVB2ZlIae39fkbT5lCEMjuTCgaeuXpVNBSsuLu6dAIgQcruWQ7wSmB+AV0p92zn+l
         sBeA==
X-Received: by 10.181.25.234 with SMTP id it10mr13289569wid.41.1433682605029;
 Sun, 07 Jun 2015 06:10:05 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 7 Jun 2015 06:10:04 -0700 (PDT)
In-Reply-To: <5573520A.90603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270970>

On Sat, Jun 6, 2015 at 10:03 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> This is a follow up series to the one posted here
> http://thread.gmane.org/gmane.comp.version-control.git/270922
>
> This patch series adds '--ponints-at', '--merged', '--no-merged' and

s/--ponints-at/--points-at/

> '--contain' options to 'ref-filter' and uses these options in
> 'for-each-ref'.
