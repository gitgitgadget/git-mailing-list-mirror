From: Will Entriken <fulldecent@gmail.com>
Subject: Re: Recursive submodule confusing output (bug?)
Date: Mon, 18 Feb 2013 10:58:12 -0500
Message-ID: <CAFwrLX5nPvySfA05CLgdfoNt-pzQbCq0o+LtGJxZyVwP0EyHcg@mail.gmail.com>
References: <CAFwrLX6EWPureNoyjuMVy13kgwyAgDBcd1Eoet7hQ1CB9OhLxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 16:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7T72-0005tV-M6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 16:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab3BRP6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 10:58:16 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:47819 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab3BRP6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 10:58:16 -0500
Received: by mail-qa0-f45.google.com with SMTP id g10so1350271qah.11
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=XF6c+xmpq4nLzBJRtl2aZ4Tn/a9RWMqxYaG9GvXn+GY=;
        b=wc2XHUN0asWXVl9wbawYp2tNPS7hdITPwZ1AUxTrF+zh6zE/T4qWIXgxKHi8v7j3iu
         bwoOGGrel2ZQ4sjqG+l3M5E8ruz3zlnqvHSzrugiFCICn30a1hYEkRszOcq82N8vDDZ0
         XOsjlB6ELL0T6ikYFwKELzDLqntaPQmEcEsinK9/8Jmlwve0rBmOKp8sHfI8bRTfb2F3
         AzOkq74qBXIZCGiyQk+EKcY8NY/ucMHaG8icoUUNfXkE5AH72iqEF75SutI7DVYy+1hs
         bifdhwVkXr3XE8Yqt6XACcMVdokTl41x+So5iyU9ozMAV7Hv6hGTKvjuk6miGbT1jVmD
         23Hg==
X-Received: by 10.49.107.4 with SMTP id gy4mr5320797qeb.63.1361203092975; Mon,
 18 Feb 2013 07:58:12 -0800 (PST)
Received: by 10.49.95.2 with HTTP; Mon, 18 Feb 2013 07:58:12 -0800 (PST)
In-Reply-To: <CAFwrLX6EWPureNoyjuMVy13kgwyAgDBcd1Eoet7hQ1CB9OhLxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216482>

Hello,

I am running:

    git submodule update --recursive

And get the output:

    Submodule path 'Submodules/evernote-ios-sdk': checked out
'391ca643c5b1cd02e9fa869a6b0760436ea452ed'
    Submodule path 'Submodules/facebook-ios-sdk': checked out
'ada467f754febd4f2871d15943e9be16b323f114'
    Submodule path 'Submodules/objectiveflickr': checked out
'f474a78c807b5fa0c887bf8efaead5be1da637ec'
    Submodule path 'Submodules/sskeychain': checked out
'8252a69cdfea562223d4dc2e2ccaf01b752d2cc6'

This is a little confusing to me, would this be more appropriate?

    Submodule path 'Submodules/ShareKit/Submodules/evernote-ios-sdk':
checked out '391ca643c5b1cd02e9fa869a6b0760436ea452ed'
    Submodule path 'Submodules/ShareKit/Submodules/facebook-ios-sdk':
checked out 'ada467f754febd4f2871d15943e9be16b323f114'
    Submodule path 'Submodules/ShareKit/Submodules/objectiveflickr':
checked out 'f474a78c807b5fa0c887bf8efaead5be1da637ec'
    Submodule path 'Submodules/ShareKit/Submodules/sskeychain':
checked out '8252a69cdfea562223d4dc2e2ccaf01b752d2cc6'

Please let me know if this is something I may fix.

Thank you,
William Entriken
