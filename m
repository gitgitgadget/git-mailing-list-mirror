From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Tue, 30 Jun 2015 14:10:49 +0200
Organization: gmx
Message-ID: <19801032cd7af95bc8030f54d740bf48@www.dscho.org>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
 <xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
 <CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
 <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 14:11:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uNj-0002BA-OM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbbF3MLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:11:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:65195 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbbF3MKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:10:53 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1zFf-1YuAfh2VxL-00u4cZ; Tue, 30 Jun 2015 14:10:50
 +0200
In-Reply-To: <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:gNIEKkpJRYDveCqnGoxf0ZY//qYeh3PC8zaaYlA/mZDQhAx0b1P
 MxkSz9Gc3uCvkdsUc96rdUgjfp4G8qzGIfQJ8GIkIGE0Sy46ZB1n2g5xnKWsCVaP0bpWaVH
 akOoHgkdffsTzwHuXxpfIAM+bIYMFlzVaQ7X+mUwNW7npZlrJ6MwXlVmkwkVF23Ok/CGYLi
 /7xy3GgUwa8MPKvjgrRgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y9lXZJwOAXY=:QX4dKw30XJd2mwY/nNQo6D
 b89VuS3mSua4zO+MhESIY0A8894eGZTa9Tk/HiQOdBdXAMRBmR2vrqkF4+UD0R5TN9JoJK/hw
 fVII85D3Z7yQD1tiAMuYy9VWmwvh+huczK+m5fEgiHmvEefPsFL9pnQWfat0BObZhf26jwe1f
 5EWdJweaeCiXnWWfsVZJoxu9/0PIN0z3fx6l01Opb93Un5Y+nmT14iXtDDvjZIRhfhrMiBQM7
 rrf+6zzgmsSPnU3wlyG/6ZeD2NrrfCjf/6TAuYjjOtVn2yoG6czSXwoiZz3awUJ+2aoHCO12+
 MxVOrVn6W1RckRsNzuR7hgp8QUZD2VdqMdYh3VAi1lReh/v4s9FBCO+edX+no77NhZ9DQND2A
 uXmED+E63PqMB1bZe19OSGpBVuhk7FTpIQgNbCwBFcycpRggS9HxMVxDZrMtzpUG/YKYIPceS
 nYwTlvi7DTGtTvpbNNYFhM/kLridmEUxDS9O+DAGXYIwmN9XT/FzRdDO3Bb8Z/Q2pnBP/dU9y
 jXOb2rHTWRWOdrG2OJj9fYcUwLPzS/YgKBW3Yw4DdY3xy27jOu3wA7IEzcV6gXTbO+EQLHIkg
 kZD0sPpl5dl9Z5SMeAuwAAYCnf3Rq92l+foVFDqkvYyyPdwkBBCKa7wuma/He+a3acGsrSQ+z
 zs6zuyKYVlcZDC0mGXCc+Xr6yvojaE1Phctp4KTgtb33a7iOw8D3VqAnx4uCFAQTPxFU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273042>

Hi Lawrence,

On 2015-06-29 18:46, Lawrence Siebert wrote:

> I appreciate your help. Okay, That all makes sense.
> 
> I would note that something like:
>  git shortlog -s "$FILENAME:  | cut -f 1 | paste -sd+ - | bc
> 
> seems like it run much faster then:
> 
>  git log --oneline "$FILENAME" | wc -l

How does it compare to `git rev-list -- "$FILENAME" | wc -l`?

Ciao,
Johannes
