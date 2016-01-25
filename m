From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Mon, 25 Jan 2016 09:32:40 +0100
Message-ID: <56A5DDA8.1030404@web.de>
References: <cover.1453632296.git.johannes.schindelin@gmx.de>
 <cover.1453709205.git.johannes.schindelin@gmx.de>
 <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 09:33:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNca7-00032t-5e
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 09:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbcAYIdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 03:33:00 -0500
Received: from mout.web.de ([212.227.15.14]:63376 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcAYIc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 03:32:58 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LwlY0-1a3cmN1gM4-016LZ6; Mon, 25 Jan 2016 09:32:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:FNsN4kfxkJeLUlFz51CR53+2jfvkBTqmHXr8EkGIGT+YuwaYUhY
 BE8+8WhDT1sQHwpK8iyWTwOMdujT8LVEu2bmuFGABj75UIL/+6xQWKAuTvRCsnMobRO5ef1
 ix1tzCXGyrFvZ/DI+Pc6DF71T0dSvm8AFWvOs7L6+r6Rl6gCyUPq0QVLfLxX0OFlXn8oV9k
 1mfsPCa5D6yU43AvC+YYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n+mENcdB9Xw=:4wDNQ4JLtuAM6wVhguyG3i
 u4REhDaxPjFsNQlvK88Zxd+xQqmlRRkS35kNiz9iUa0vXqnBVDGpboyFf2N35tfGdJEqA3ycs
 l2y16kUUyd/FKzi1vz6Qt4wxFExKrwzI0p/4U1GTQ7cxM0bX6j1xbVk9WEMcQ1LIdZ0MKMfEu
 VwetBR7lqccE2e5UQO4wUixj49lElHVy4HCvXARiHP1FIEqYZQ0ZsKfkwhrPbdmeYMtan3kzL
 VOuLcIsqBimG+TFBTS574g+cEYzHK47h9hWcUctOkfrpDnLY11S1kH04zceJ1hSlgaWLczX4A
 CHLWe//zYDLabv2C8kr07/+9U2xfl7sBetKJ9Rfw6bhwWsZGFXAzq3/dbYLioohoc5dSyh5sH
 wRmC3XVGF5t/Q6ag3DHTZdHoOIFHWzz9CX771ExwfJqGOmdk8+Wyq5BV+ZChYjYz+sr3W31eB
 z/cOkwN8GDG3UrBDIKFwz0tiOuV1ALJwxwjnwu0XtPaGFVHIR4YUnG3mv3B7VID4ISIr4m8Mu
 jqo5MdCarq/yFcZstwWNrQGbEqY5prsrYe4kWOO0xS+wzC6Ki+wAPoVHnEF5MuyHilgxt31iH
 vt6EyOCU0UOIrNXFrmX54Ntu9pjvvcM8679hiOnmg1ED5a8wJjbQGRNErwThSK/F2rpMW9x00
 BU1ExamUAPOeXAMvUEhgyfthW91No4IcxOaoq5FadVV0RVg26+yAhCb57x4rJyDCbk6PLyRfQ
 y6XnSsJ2yQNW42TO7PFr50ximDeIQGRt+xVhP5CKsXfSl02NevTHQ6mFypmo0ZQw7QKPy1zr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284726>

On 25.01.16 09:07, Johannes Schindelin wrote:
[]
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 625198e..c852acc 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -143,6 +143,35 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
>  	return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
>  }
>  
> +/*
> + * Returns 1 if the i'th line ends in CR/LF (if it is the last line and
> + * has no eol, the preceding line, if any), 0 if it ends in LF-only, and
> + * -1 if the line ending cannot be determined.
> + */
> +static int is_eol_crlf(xdfile_t *file, int i)
Minot nit: Could that be 
is_eol_crlf(xdfile_t *file, int lineno)
(or may be)
is_eol_crlf(const xdfile_t *file, int lineno)
(or may be)
has_eol_crlf(const xdfile_t *file, int lineno)

> +{
> +	long size;
> +
> +	if (i < file->nrec - 1)
> +		/* All lines before the last *must* end in LF */
> +		return (size = file->recs[i]->size) > 1 &&
> +			file->recs[i]->ptr[size - 2] == '\r';
> +	if (!file->nrec)
> +		/* Cannot determine eol style from empty file */
> +		return -1;
> +	if ((size = file->recs[i]->size) &&
> +			file->recs[i]->ptr[size - 1] == '\n')
> +		/* Last line; ends in LF; Is it CR/LF? */
> +		return size > 1 &&
> +			file->recs[i]->ptr[size - 2] == '\r';
> +	if (!i)
> +		/* The only line has no eol */
> +		return -1;
> +	/* Determine eol from second-to-last line */
> +	return (size = file->recs[i - 1]->size) > 1 &&
> +		file->recs[i - 1]->ptr[size - 2] == '\r';
> +}
> +
