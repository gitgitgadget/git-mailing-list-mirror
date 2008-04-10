From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Question about Tig
Date: Thu, 10 Apr 2008 19:13:56 +0200
Message-ID: <2c6b72b30804101013p576847cav28d8238f8bf0d3c2@mail.gmail.com>
References: <47FE3679.1020604@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Thu Apr 10 19:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk0MF-00038e-AH
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 19:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYDJRN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbYDJRN6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 13:13:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:46395 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbYDJRN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 13:13:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so80744wxd.4
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WOacw5VYngO1eEuuCHSJ8QpytCG16tWI3P5IyCWvDDk=;
        b=jBvXwlnXdVKjuUQmETueicJjMy/vN62DSbfqzJrgoUSddHrQ6ZGp3e9R1LeYz0XShjyyLEigxU6Woe9NMtOuvrv5bLwSZPGYuLxpJ2Sidj7//qRS+3Y5QIEXVFMeptRqGGjt44KeLAL47qLiZ0Q0LGsNHlFyZw9i0x3rcw6jHwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RzVSgN71Zbsg2Ey0Ybq0RQSvxY3WKwaRkr+B54tB8kwz4ZrNKZ+D8nwvXy0qbvdJvhb/nhkfhPHPeGghsO7AxCtvFXVgEi1Fhgz9guqYKOPHNm5IuoUaV+vI4okRX++dPinNoMFQ3yCv5q2SKlWef9bkegmdkcVIr+hVT1t/XqM=
Received: by 10.141.83.15 with SMTP id k15mr920431rvl.120.1207847636206;
        Thu, 10 Apr 2008 10:13:56 -0700 (PDT)
Received: by 10.141.3.15 with HTTP; Thu, 10 Apr 2008 10:13:56 -0700 (PDT)
In-Reply-To: <47FE3679.1020604@obry.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79239>

On Thu, Apr 10, 2008 at 5:47 PM, Pascal Obry <pascal@obry.net> wrote:
> I want to stage only some hunks and not the whole file.
>
>  The way to do this is:
>
>    - to open the status view S
>    - select a file
>    - move the cursor up/down using j/k keys
>    - when inside the right hunk, press 'u'
>
>  Fine. But a bit tedious. Is there a way to navigate one hunk

Currently there is no way to do this using a keybinding. I will put
it on the list of stuff to work on. This, together with the ability to
keep the position across staging 'u'pdates, will be a much needed
improvement.

For now you can search for "@@" and use that to jump one hunk
forward.

-- 
Jonas Fonseca
